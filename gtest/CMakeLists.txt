add_executable(test_gtest test_gtest.cpp)
target_link_libraries(test_gtest gtest)

add_executable(test_fact test_fact.cpp)
target_link_libraries(test_fact gtest)

add_executable(test_list test_list.cpp)
