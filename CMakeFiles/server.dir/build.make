# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main"

# Include any dependencies generated for this target.
include CMakeFiles/server.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/server.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/server.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/server.dir/flags.make

CMakeFiles/server.dir/src/wserver.c.o: CMakeFiles/server.dir/flags.make
CMakeFiles/server.dir/src/wserver.c.o: src/wserver.c
CMakeFiles/server.dir/src/wserver.c.o: CMakeFiles/server.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/server.dir/src/wserver.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/server.dir/src/wserver.c.o -MF CMakeFiles/server.dir/src/wserver.c.o.d -o CMakeFiles/server.dir/src/wserver.c.o -c "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/src/wserver.c"

CMakeFiles/server.dir/src/wserver.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/server.dir/src/wserver.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/src/wserver.c" > CMakeFiles/server.dir/src/wserver.c.i

CMakeFiles/server.dir/src/wserver.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/server.dir/src/wserver.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/src/wserver.c" -o CMakeFiles/server.dir/src/wserver.c.s

CMakeFiles/server.dir/src/io_helper.c.o: CMakeFiles/server.dir/flags.make
CMakeFiles/server.dir/src/io_helper.c.o: src/io_helper.c
CMakeFiles/server.dir/src/io_helper.c.o: CMakeFiles/server.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/server.dir/src/io_helper.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/server.dir/src/io_helper.c.o -MF CMakeFiles/server.dir/src/io_helper.c.o.d -o CMakeFiles/server.dir/src/io_helper.c.o -c "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/src/io_helper.c"

CMakeFiles/server.dir/src/io_helper.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/server.dir/src/io_helper.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/src/io_helper.c" > CMakeFiles/server.dir/src/io_helper.c.i

CMakeFiles/server.dir/src/io_helper.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/server.dir/src/io_helper.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/src/io_helper.c" -o CMakeFiles/server.dir/src/io_helper.c.s

CMakeFiles/server.dir/src/request.c.o: CMakeFiles/server.dir/flags.make
CMakeFiles/server.dir/src/request.c.o: src/request.c
CMakeFiles/server.dir/src/request.c.o: CMakeFiles/server.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/server.dir/src/request.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/server.dir/src/request.c.o -MF CMakeFiles/server.dir/src/request.c.o.d -o CMakeFiles/server.dir/src/request.c.o -c "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/src/request.c"

CMakeFiles/server.dir/src/request.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/server.dir/src/request.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/src/request.c" > CMakeFiles/server.dir/src/request.c.i

CMakeFiles/server.dir/src/request.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/server.dir/src/request.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/src/request.c" -o CMakeFiles/server.dir/src/request.c.s

# Object files for target server
server_OBJECTS = \
"CMakeFiles/server.dir/src/wserver.c.o" \
"CMakeFiles/server.dir/src/io_helper.c.o" \
"CMakeFiles/server.dir/src/request.c.o"

# External object files for target server
server_EXTERNAL_OBJECTS =

server: CMakeFiles/server.dir/src/wserver.c.o
server: CMakeFiles/server.dir/src/io_helper.c.o
server: CMakeFiles/server.dir/src/request.c.o
server: CMakeFiles/server.dir/build.make
server: CMakeFiles/server.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_4) "Linking C executable server"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/server.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/server.dir/build: server
.PHONY : CMakeFiles/server.dir/build

CMakeFiles/server.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/server.dir/cmake_clean.cmake
.PHONY : CMakeFiles/server.dir/clean

CMakeFiles/server.dir/depend:
	cd "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main" "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main" "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main" "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main" "/mnt/c/Users/acous/Documents/College/Spring 2025/CYB 3053 Operating Systems/OSProj3-main/CMakeFiles/server.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : CMakeFiles/server.dir/depend

