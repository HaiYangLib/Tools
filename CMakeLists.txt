cmake_minimum_required(VERSION 3.2.0)

project(tool)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")

# gtest
set(gtest_path ${PROJECT_SOURCE_DIR}/gtest/gtest-release-1.10.0-gcc-install)
include_directories(${gtest_path}/include)
link_directories(${gtest_path}/lib)
add_subdirectory(gtest)

# osgb_eigen
find_package(Eigen3)
include_directories(${EIGEN3_INCLUDE_DIR})
find_package(osqp REQUIRED)

set(osgb_eigen_path ${PROJECT_SOURCE_DIR}/osqp_eigen/osqp_eigen-v0.7.0-gcc-install)
include_directories(${osgb_eigen_path}/include)
link_directories(${osgb_eigen_path}/lib)
add_subdirectory(osqp_eigen)
