//
// Created by hhy on 2022/3/11.
//

#include <OsqpEigen/OsqpEigen.h>
#include <chrono>

int main() {
  auto t1 =
      std::chrono::high_resolution_clock::now().time_since_epoch().count();
  constexpr double tolerance = 1e-4;

  Eigen::SparseMatrix<double> H_s(2, 2);
  H_s.insert(0, 0) = 4;
  H_s.insert(0, 1) = 1;
  H_s.insert(1, 0) = 1;
  H_s.insert(1, 1) = 2;

  Eigen::SparseMatrix<double> A_s(3, 2);
  A_s.insert(0, 0) = 1;
  A_s.insert(0, 1) = 1;
  A_s.insert(1, 0) = 1;
  A_s.insert(2, 1) = 1;

  Eigen::Vector2d gradient;
  gradient << 1, 1;

  Eigen::Vector3d lowerBound;
  lowerBound << 1, 0, 0;

  Eigen::Vector3d upperBound;
  upperBound << 1, 0.7, 0.7;

  OsqpEigen::Solver solver;
  solver.settings()->setVerbosity(true);
  solver.settings()->setAlpha(1.0);

  //  assert(solver.data()->setHessianMatrix(H_s)== true);
  solver.data()->setNumberOfVariables(2);
  solver.data()->setNumberOfConstraints(3);

  assert(solver.data()->setHessianMatrix(H_s));
  assert(solver.data()->setGradient(gradient));
  assert(solver.data()->setLinearConstraintsMatrix(A_s));
  assert(solver.data()->setLowerBound(lowerBound));
  assert(solver.data()->setUpperBound(upperBound));
  assert(solver.initSolver());
  assert(solver.solveProblem() == OsqpEigen::ErrorExitFlag::NoError);

  auto t2 =
      std::chrono::high_resolution_clock::now().time_since_epoch().count();
  std::cout << "used time: " << double(t2 - t1) / (1e6) << "ms" << std::endl;
  // assert(solver.solveProblem() == OsqpEigen::ErrorExitFlag::NoError);
  Eigen::Vector2d expectedSolution;
  expectedSolution << 0.3, 0.7;

  assert(solver.getSolution().isApprox(expectedSolution, tolerance));

  std::cout << solver.getSolution() << std::endl;
}