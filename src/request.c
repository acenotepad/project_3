#include "io_helper.h"
#include "request.h"

#define MAXBUF (8192)

// below default values are defined in 'request.h'
int num_threads = DEFAULT_THREADS;
int buffer_max_size = DEFAULT_BUFFER_SIZE;
int scheduling_algo = DEFAULT_SCHED_ALGO;	

// Starter code for producer consumer from slides - will edit
pthread_cond_t buffer_has_items = PTHREAD_COND_INITIALIZER;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
//cond_t buffer_has_items;
//mutex_t mutex;

//
//	TODO: add code to create and manage the buffer
//

struct web_requests { //web_requests is a type now
  int fd; //file descriptor
  char filename[MAXBUF];
  int sbuf_size; //buffer size
};

struct web_requests req_array[MAXBUF]; //array of type web_requests
// make it easier to get the length of the request array
int length_req_array = sizeof(req_array) / sizeof(req_array[0]);
int num_items = 0;

// tried something very similar to the code given in class, but I think I need to do something closer to the variable size
// these might not even been needed; use num_items to wake up child threads if something is in the array, not just a full/empty condition
// void producer(void arg) {
//   pthread_mutex_lock(&mutex);
//   while (num_items == 0)
//   pthread_cond_wait(&empty, &mutex);
//   // Call request_handle to get requests in the buffer
//   pthread_cond_signal(&fill);
//   pthread_mutex_unlock(&mutex);
// }

// void consumer(void arg){
//   pthread_mutex_lock(&mutex);
//   while (num_items != 0)
//   pthread_cond_wait(&fill, &mutex);
//   // Call thread_request_serve_static
//   pthread_cond_signal(&empty);
//   pthread_mutex_unlock(&mutex);
// }

//
// Sends out HTTP response in case of errors
//
void request_error(int fd, char *cause, char *errnum, char *shortmsg, char *longmsg) {
    char buf[MAXBUF], body[MAXBUF];
    
    // Create the body of error message first (have to know its length for header)
    sprintf(body, ""
	    "<!doctype html>\r\n"
	    "<head>\r\n"
	    "  <title>CYB-3053 WebServer Error</title>\r\n"
	    "</head>\r\n"
	    "<body>\r\n"
	    "  <h2>%s: %s</h2>\r\n" 
	    "  <p>%s: %s</p>\r\n"
	    "</body>\r\n"
	    "</html>\r\n", errnum, shortmsg, longmsg, cause);
    
    // Write out the header information for this response
    sprintf(buf, "HTTP/1.0 %s %s\r\n", errnum, shortmsg);
    write_or_die(fd, buf, strlen(buf));
    
    sprintf(buf, "Content-Type: text/html\r\n");
    write_or_die(fd, buf, strlen(buf));
    
    sprintf(buf, "Content-Length: %lu\r\n\r\n", strlen(body));
    write_or_die(fd, buf, strlen(buf));
    
    // Write out the body last
    write_or_die(fd, body, strlen(body));
    
    // close the socket connection
    close_or_die(fd);
}

//
// Reads and discards everything up to an empty text line
//
void request_read_headers(int fd) {
    char buf[MAXBUF];
    
    readline_or_die(fd, buf, MAXBUF);
    while (strcmp(buf, "\r\n")) {
		readline_or_die(fd, buf, MAXBUF);
    }
    return;
}

//
// Return 1 if static, 0 if dynamic content (executable file)
// Calculates filename (and cgiargs, for dynamic) from uri
//
int request_parse_uri(char *uri, char *filename, char *cgiargs) {
    char *ptr;
    
    if (!strstr(uri, "cgi")) { 
	// static
	strcpy(cgiargs, "");
	sprintf(filename, ".%s", uri);
	if (uri[strlen(uri)-1] == '/') {
	    strcat(filename, "index.html");
	}
	return 1;
    } else { 
	// dynamic
	ptr = index(uri, '?');
	if (ptr) {
	    strcpy(cgiargs, ptr+1);
	    *ptr = '\0';
	} else {
	    strcpy(cgiargs, "");
	}
	sprintf(filename, ".%s", uri);
	return 0;
    }
}

//
// Fills in the filetype given the filename
//
void request_get_filetype(char *filename, char *filetype) {
    if (strstr(filename, ".html")) 
		strcpy(filetype, "text/html");
    else if (strstr(filename, ".gif")) 
		strcpy(filetype, "image/gif");
    else if (strstr(filename, ".jpg")) 
		strcpy(filetype, "image/jpeg");
    else 
		strcpy(filetype, "text/plain");
}

//
// Handles requests for static content
//
void request_serve_static(int fd, char *filename, int filesize) {
    int srcfd;
    char *srcp, filetype[MAXBUF], buf[MAXBUF];
    
    request_get_filetype(filename, filetype);
    srcfd = open_or_die(filename, O_RDONLY, 0);
    
    // Rather than call read() to read the file into memory, 
    // which would require that we allocate a buffer, we memory-map the file
    srcp = mmap_or_die(0, filesize, PROT_READ, MAP_PRIVATE, srcfd, 0);
    close_or_die(srcfd);
    
    // put together response
    sprintf(buf, ""
	    "HTTP/1.0 200 OK\r\n"
	    "Server: OSTEP WebServer\r\n"
	    "Content-Length: %d\r\n"
	    "Content-Type: %s\r\n\r\n", 
	    filesize, filetype);
       
    write_or_die(fd, buf, strlen(buf));
    
    //  Writes out to the client socket the memory-mapped file 
    write_or_die(fd, srcp, filesize);
    munmap_or_die(srcp, filesize);
}

//
// Fetches the requests from the buffer and handles them (thread logic)
//
void* thread_request_serve_static(void* arg)
{
	// TODO: write code to actualy respond to HTTP requests
  // Hint: probably do a while(1) or while(true)
  while (1){
    pthread_mutex_lock(&mutex);
    pthread_cond_wait(&buffer_has_items, &mutex);

    struct web_requests handle_request = req_array[0]; // if change how parent adds to array, line 181 cannot use req_array[0]
    request_serve_static(handle_request.fd, handle_request.filename, handle_request.sbuf_size);
    for (int i = 0; i < num_items; i++){
      // do the swapping
      req_array[i] = req_array[i+1];
    }
    num_items--; // subtract from num_items

    pthread_mutex_unlock(&mutex);
  }
}

//
// Initial handling of the request
//
void request_handle(int fd) {
    int is_static;
    struct stat sbuf;
    char buf[MAXBUF], method[MAXBUF], uri[MAXBUF], version[MAXBUF];
    char filename[MAXBUF], cgiargs[MAXBUF];
    
	// get the request type, file path and HTTP version
    readline_or_die(fd, buf, MAXBUF);
    sscanf(buf, "%s %s %s", method, uri, version);
    printf("method:%s uri:%s version:%s\n", method, uri, version);

	// verify if the request type is GET or not
    if (strcasecmp(method, "GET")) {
		request_error(fd, method, "501", "Not Implemented", "server does not implement this method");
		return;
    }
    request_read_headers(fd);
    
	// check requested content type (static/dynamic)
    is_static = request_parse_uri(uri, filename, cgiargs);
    
	// get some data regarding the requested file, also check if requested file is present on server
    if (stat(filename, &sbuf) < 0) {
		request_error(fd, filename, "404", "Not found", "server could not find this file");
		return;
    }
    
	// verify if requested content is static
    if (is_static) {
		if (!(S_ISREG(sbuf.st_mode)) || !(S_IRUSR & sbuf.st_mode)) {
			request_error(fd, filename, "403", "Forbidden", "server could not read this file");
			return;
		}
  // if not in current directory: abort
    // if (1!=1) { //Change content in parentheses
    //   exit(1);
    // }
		
    struct web_requests new_request = {fd, filename, sbuf.st_size};

		// TODO: write code to add HTTP requests in the buffer based on the scheduling policy
    switch (scheduling_algo) {
      case 0: // FIFO
        pthread_mutex_lock(&mutex);
        // waiting condition
        req_array[num_items] = new_request; // add request to end of the list
        num_items++;
        // wake/signal condition thing
        pthread_cond_signal(&buffer_has_items);
        pthread_mutex_unlock(&mutex);
      
      case 1: // SFF (Smallest file first)
        pthread_mutex_lock(&mutex);
        // waiting condition

        // Loop through req_array using i (if len > 0) to find where to insert request
        if (num_items > 0) {
          for (int i = 0; i < num_items; i++) { // for each request in req_array
            //int i.sbuf_size; //Change to size = getting filesize of pending
            if (req_array[i].sbuf_size > new_request.sbuf_size) { //if req_array[i] size > current size:
              for (int j = num_items; j > i-1; j--){
                // do the swapping
                if (j == i){ // if j = i, this is where the new value is inserted
                  req_array[j] = req_array[i];
                }
                else { // otherwise, continue shifting everything up
                req_array[j+1] = req_array[j];
                }
              }
            }
          }
        } else {
            req_array[num_items] = new_request; // if no match, append to end of array
        }

        pthread_cond_signal(&buffer_has_items); // wake/signal condition thing
        pthread_mutex_unlock(&mutex);
      case 2: // Random
        pthread_mutex_lock(&mutex);
        // waiting condition
        // add request randomly in the list
        int insert_placeholder = rand() % num_items;
        for (int i=num_items; i > insert_placeholder - 1; i--){
          if (i>insert_placeholder){
            req_array[i+1] = req_array[i];
          }
          else if (i = insert_placeholder){
            req_array[i] = new_request;
          }
        }
        pthread_cond_signal(&buffer_has_items); // wake/signal condition thing
        pthread_mutex_unlock(&mutex);
        }
        // generate between 0 and num of items

    } else {
		request_error(fd, filename, "501", "Not Implemented", "server does not serve dynamic content request");
    }
}