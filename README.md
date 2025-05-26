# fluent_libc

Fluent's C standard library. It relies
on the system's C standard library (e.g. musl, glibc, etc.) to provide
system calls and other low-level functionality. Fluent's C standard library
implements additional features and functions that are not provided by the system's
C standard library.

## How to use

Fluent's C library is not installable, you have to include
it in your project. To do this, you need to add the following line to your
CMakeLists.txt file:

Example:
```cmake
include(FetchContent)

FetchContent_Declare(
        fluent_libc
        GIT_REPOSITORY https://github.com/rodrigoo-r/fluent_libc
        GIT_TAG        master
)

FetchContent_MakeAvailable(fluent_libc)
target_include_directories(your_project PRIVATE ${CMAKE_BINARY_DIR}/_deps/fluent_libc-src/include)
target_link_libraries(your_project PRIVATE fluent_libc)
# Usually not required since fluent_libc already defines it
add_definitions(-DDEBUG -DFLUENT_LIBC_RELEASE=1)
```