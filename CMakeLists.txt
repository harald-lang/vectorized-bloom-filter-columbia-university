cmake_minimum_required(VERSION 3.6)
project(vectorized_bloom_filter)

set(CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS} -march=core-avx2")

set(SOURCE_FILES vbf.c)
add_executable(vectorized_bloom_filter ${SOURCE_FILES})
target_link_libraries(vectorized_bloom_filter pthread rt m)

configure_file(bf_performance.sh bf_performance.sh COPYONLY)
