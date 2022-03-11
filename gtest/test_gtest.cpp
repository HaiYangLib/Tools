//
// Created by hhy on 2022/2/8.
//
#include <iostream>

#include "gtest/gtest.h"

int add(int lhs, int rhs) { return lhs + rhs; }

int main(int argc, char const *argv[]) {

  std::cout<<"begin test"<<std::endl;

  EXPECT_EQ(add(1,1), 2); // PASS
  EXPECT_EQ(add(1,1), 1) << "FAILED: EXPECT: 2, but given 1";; // FAILDED

  std::cout<<"end test"<<std::endl;
  return 0;
}