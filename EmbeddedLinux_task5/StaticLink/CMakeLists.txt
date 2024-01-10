#Set min CMake version
cmake_minimum_required(VERSION 3.1...3.2)

# Write the project description
project(Calculator VERSION 1.1
    DESCRIPTION "This is a simple calculator application"
    LANGUAGES C)

# Set the source files
set(SOURCES
   Sources/add.c
   Sources/sub.c
   Sources/mult.c
   Sources/div.c
   Sources/mod.c
)

# Set the header files
set(HEADERS
   Includes/add.h
   Includes/sub.h
   Includes/mult.h
   Includes/div.h
   Includes/mod.h
)

# Create a static library
add_library(calculator_lib STATIC ${SOURCES})

# Set the executable
add_executable(calculator_exec main.c)

# Set include directories for the executable
target_include_directories(calculator_exec PUBLIC ${HEADERS})

# Link the static library to the executable
target_link_libraries(calculator_exec PRIVATE calculator_lib)



