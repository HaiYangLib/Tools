CXX_TAG=gcc
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++

# CXX_TAG=c8
# export CC=/usr/bin/clang-8
# export CXX=/usr/bin/clang++-8

VERSION=3.4.0 # 版本
BASENAME=eigen-${VERSION}-${CXX_TAG}

RM_SOURCE="ture"      # 是否删除源码
RM_BUILD="true"        # 是否删除build文件夹
INSTALL="true"         # 是否编译及安装
INSTALL_IN_SYS="true" #是否安装到系统目录下

SOURCE_DIR=${BASENAME}-source   # 源代码文件夹
BUILD_DIR=${BASENAME}-build     # build文件夹
INSTALL_DIR=${BASENAME}-install # 安装文件夹

rm -Rf ${BUILD_DIR} ${INSTALL_DIR}

if [ -d ${SOURCE_DIR} ]; then
  echo "${SOURCE_DIR} already existence"
else
  echo "============= Retrieving Eigen. ================"
  wget https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-${VERSION}.tar.gz
  tar -zxvf eigen-${VERSION}.tar.gz
  mv eigen-${VERSION} ${SOURCE_DIR}
fi

if [ "${INSTALL}" == "true" ]; then
  echo "========== Building Eigen with libstdc++. ========"
  mkdir -p ${BUILD_DIR}
  pushd ${BUILD_DIR} >/dev/null

  if [ "${INSTALL_IN_SYS}" == "true" ]; then
    cmake -G "Ninja" \
      -DCMAKE_CXX_FLAGS="-std=c++14" \
      ../${SOURCE_DIR}
  else
    cmake -G "Ninja" \
      -DCMAKE_CXX_FLAGS="-std=c++14" \
      -DCMAKE_INSTALL_PREFIX="../${INSTALL_DIR}" \
      ../${SOURCE_DIR}
  fi

  ninja
  ninja install

  popd >/dev/null

fi

if [ "${RM_BUILD}" == "true" ]; then
  rm -Rf ${BUILD_DIR}
fi

if [ "${RM_SOURCE}" == "true" ]; then
  rm -Rf ${SOURCE_DIR}
  rm eigen-${VERSION}.*
fi
