cmake_minimum_required(VERSION 3.30)
project(fluent_libc C)

set(CMAKE_C_STANDARD 11)

add_library(fluent_libc STATIC library.c)
