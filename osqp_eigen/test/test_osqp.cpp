//
// Created by hhy on 2022/3/11.
//
#include "OsqpEigen/OsqpEigen.h"
#include <Eigen/Dense>
#include <chrono>
#include <iostream>

using namespace std;

static uint64_t Now() {
  auto now = std::chrono::high_resolution_clock::now();
  return now.time_since_epoch().count();
}

int main() {
  OsqpEigen::Solver solver;

  auto t1 = Now();
  solver.settings()->setVerbosity(true);
  solver.settings()->setAlpha(1.0);

  int numOfVar = 2;
  int numOfCons = 5;

  solver.data()->setNumberOfVariables(numOfVar);
  solver.data()->setNumberOfConstraints(numOfCons);

  Eigen::SparseMatrix<double> hessian;
  Eigen::VectorXd gradient;
  Eigen::SparseMatrix<double> linearMatrix;
  Eigen::VectorXd lowerBound;
  Eigen::VectorXd upperBound;

  hessian.resize(numOfVar, numOfVar);
  gradient.resize(numOfVar);
  linearMatrix.resize(numOfCons, numOfVar);
  lowerBound.resize(numOfCons);
  upperBound.resize(numOfCons);

  hessian.insert(0, 0) = 1;
  hessian.insert(0, 1) = 0;
  hessian.insert(1, 0) = 0;
  hessian.insert(1, 1) = 0;
  std::cout << "hessian:\n" << hessian << "\n";

  gradient << 3, 4;
  std::cout << "gradient:\n" << gradient << "\n";

  linearMatrix.insert(0, 0) = -1;
  linearMatrix.insert(1, 0) = 0;
  linearMatrix.insert(2, 0) = -1;
  linearMatrix.insert(3, 0) = 2;
  linearMatrix.insert(4, 0) = 3;

  linearMatrix.insert(0, 1) = 0;
  linearMatrix.insert(1, 1) = -1;
  linearMatrix.insert(2, 1) = -3;
  linearMatrix.insert(3, 1) = 5;
  linearMatrix.insert(4, 1) = 4;

  std::cout << "linearMatrix:\n" << linearMatrix << "\n";

  lowerBound << -OsqpEigen::INFTY, -OsqpEigen::INFTY, -OsqpEigen::INFTY,
      -OsqpEigen::INFTY, -OsqpEigen::INFTY;
  upperBound << 0, 0, -15, 100, 80;
  std::cout << "lowerBound:\n" << lowerBound << "\n";
  std::cout << "upperBound:\n" << upperBound << "\n";

  assert(solver.data()->setHessianMatrix(hessian));
  assert(solver.data()->setGradient(gradient));
  assert(solver.data()->setLinearConstraintsMatrix(linearMatrix));
  assert(solver.data()->setLowerBound(lowerBound));
  assert(solver.data()->setUpperBound(upperBound));

  //  assert(InitMat(solver));
  assert(solver.initSolver());

  //  assert(solver.solve()== true);
  assert(solver.solveProblem() == OsqpEigen::ErrorExitFlag::NoError);

  auto res = solver.getSolution();
  auto t2 = Now();
  std::cout << "use time: " << double(t2 - t1) / (1e6) << "ms" << std::endl;

  cout << res << endl;
}
