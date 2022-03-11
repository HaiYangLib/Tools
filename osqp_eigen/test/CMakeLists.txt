add_executable(test_osqp test_osqp.cpp )
target_link_libraries(test_osqp PRIVATE osqp::osqp OsqpEigen)

add_executable(test_osqp2 test_osqp2.cpp )
target_link_libraries(test_osqp2 PRIVATE osqp::osqp OsqpEigen)

add_executable(test_osqp3 test_osqp3.cpp  )
target_link_libraries(test_osqp3 PRIVATE osqp::osqp OsqpEigen)