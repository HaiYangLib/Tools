#include <iostream>

#include "gtest/gtest.h"

int Factorial(int n) {
  int result = 1;
  for (int i = 1; i <= n; i++) {
    result *= i;
  }

  return result;
}

// 下面三个 TEST 都是属于同一个 test suite，即 FactorialTest
// 正数为一组
TEST(FactorialTest, Negative) {
  EXPECT_EQ(1, Factorial(-5));
  EXPECT_EQ(1, Factorial(-1));
  EXPECT_GT(Factorial(-10), 0);
}
// 0
TEST(FactorialTest, Zero) { EXPECT_EQ(1, Factorial(0)); }
// 负数为一组
TEST(FactorialTest, Positive) {
  EXPECT_EQ(1, Factorial(1));
  EXPECT_EQ(2, Factorial(2));
  EXPECT_EQ(6, Factorial(3));
  EXPECT_EQ(40320, Factorial(8));
}

int main(int argc, char **argv) {
  std::cout<<"begin test"<<std::endl;
  printf("Running main() from %s\n", __FILE__);
  testing::InitGoogleTest(&argc, argv);
  RUN_ALL_TESTS();
  std::cout<<"end test"<<std::endl;
  return 0;
}