//
// Created by hhy on 2022/2/8.
//
#include <iostream>

#include "gtest/gtest.h"

class QueueTestSmpl3 : public testing::Test { // 继承了 testing::Test
protected:
  static void SetUpTestSuite() {
    std::cout << "run before first case..." << std::endl;
  }

  static void TearDownTestSuite() {
    std::cout << "run after last case..." << std::endl;
  }

  virtual void SetUp() override {
    std::cout << "enter into SetUp()" << std::endl;
    q1_.Enqueue(1);
    q2_.Enqueue(2);
    q2_.Enqueue(3);
  }

  virtual void TearDown() override {
    std::cout << "exit from TearDown" << std::endl;
  }

  static int Double(int n) { return 2 * n; }

  void MapTester(const Queue<int> *q) {
    const Queue<int> *const new_q = q->Map(Double);

    ASSERT_EQ(q->Size(), new_q->Size());

    for (const QueueNode<int> *n1 = q->Head(), *n2 = new_q->Head();
         n1 != nullptr; n1 = n1->next(), n2 = n2->next()) {
      EXPECT_EQ(2 * n1->element(), n2->element());
    }

    delete new_q;
  }

  Queue<int> q0_;
  Queue<int> q1_;
  Queue<int> q2_;
};