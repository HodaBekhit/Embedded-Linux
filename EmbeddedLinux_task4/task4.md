# TASK 4:

## objectives:

Create a simple application that utilizes the libmcal.a static library. Ensure the application
includes the full headers for Digital I/O (dio.c) and Port (port.c). Test the output ELF file on
your AVR development board.

## steps:

1- Compile all source files (including the application) into object files

![Screenshot from 2024-01-04 22-37-27](https://github.com/HodaBekhit/Embedded-Linux/assets/151033711/5ba29700-1872-4162-b3ce-f9a49639926d)

2-Create a static library (libmcal.a) from the object files and Clean up temporary object files

3-Compile the application with libmcal.a

4- Convert ELF to HEX to program AVR.



## why using a static library (libmcal.a) in AVR applications over dynamic libraries.

Because dynamic linking are done by the OS, where the system loader load the required shared libraries in runtime. But AVR can't compile over this OS due to the limited resources of the AVR, so we use only static libraries with AVR.

