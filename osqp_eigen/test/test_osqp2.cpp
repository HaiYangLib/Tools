//
// Created by hhy on 2022/3/11.
//
#include "OsqpEigen/OsqpEigen.h"
#include <Eigen/Dense>
#include <iostream>

using namespace std;

int main() {
  OsqpEigen::Solver solver;

  // assert(InitMat(solver));
  int numOfVar = 3;
  int numOfCons = 4;

  Eigen::SparseMatrix<double> hessian(numOfVar, numOfVar);
  hessian.insert(0, 0) = 1;
  hessian.insert(0, 1) = -1;
  hessian.insert(0, 2) = 1;
  hessian.insert(1, 0) = -1;
  hessian.insert(1, 1) = 2;
  hessian.insert(1, 2) = -2;
  hessian.insert(2, 0) = 1;
  hessian.insert(2, 1) = -2;
  hessian.insert(2, 2) = 4;
  std::cout << "hessian:" << hessian << std::endl;
  /* hessian << 1, -1, 1,
           -1, 2, -2,
            1, -2, 4;*/

  Eigen::SparseMatrix<double> linearMatrix(numOfCons, numOfVar);
  linearMatrix.insert(0, 0) = 1;
  linearMatrix.insert(1, 1) = 1;
  linearMatrix.insert(2, 2) = 1;
  linearMatrix.insert(3, 0) = 1;
  linearMatrix.insert(3, 1) = 1;
  linearMatrix.insert(3, 2) = 1;
  std::cout << " linearMatrix:" << linearMatrix << std::endl;
  /*linearMatrix << 1, 0, 0,
                0, 1, 0,
                0, 0, 1,
                1, 1, 1;*/

  Eigen::Vector3d gradient;
  gradient << 2, -3, 1;
  std::cout << "gradient:\n" << gradient << std::endl;

  Eigen::VectorXd lowerBound;
  lowerBound.resize(4, 1);
  lowerBound << 0, 0, 0, 0.4;
  std::cout << "lowerBound:\n" << lowerBound << std::endl;

  Eigen::VectorXd upperBound;
  upperBound.resize(4, 1);
  upperBound << 1, 1, 1, 0.5;

  solver.settings()->setVerbosity(true);
  solver.settings()->setAlpha(1.0);

  //  assert(solver.data()->setHessianMatrix(H_s)== true);
  solver.data()->setNumberOfVariables(numOfVar);
  solver.data()->setNumberOfConstraints(numOfCons);

  assert(solver.data()->setHessianMatrix(hessian));
  assert(solver.data()->setGradient(gradient));
  assert(solver.data()->setLinearConstraintsMatrix(linearMatrix));
  assert(solver.data()->setLowerBound(lowerBound));
  assert(solver.data()->setUpperBound(upperBound));

  assert(solver.initSolver());

  // assert(solver.solve() == true);
  assert(solver.solveProblem() == OsqpEigen::ErrorExitFlag::NoError);

  std::cout << solver.getSolution() << std::endl;
}