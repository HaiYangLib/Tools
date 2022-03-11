cmake_minimum_required(VERSION 3.2.0)

project(tool)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")

set(gtest_path ${PROJECT_SOURCE_DIR}/gtest/gtest-release-1.10.0-gcc-install)
include_directories(${gtest_path}/include)
link_directories(${gtest_path}/lib)

add_subdirectory(gtest)

