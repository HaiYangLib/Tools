#CXX_TAG=gcc
#export CC=/usr/bin/gcc
#export CXX=/usr/bin/g++

CXX_TAG=c8
export CC=/usr/bin/clang-8
export CXX=/usr/bin/clang++-8

VERSION=v0.3.5 # 版本
BASENAME=glog-${VERSION}-${CXX_TAG}

RM_SOURCE="false" # 是否删除源码
RM_BUILD="true"   # 是否删除build文件夹
INSTALL="true"    # 是否编译及安装

SOURCE_DIR=${BASENAME}-source   # 源代码文件夹
BUILD_DIR=${BASENAME}-build     # build文件夹
INSTALL_DIR=${BASENAME}-install # 安装文件夹

if [ -d "${INSTALL_DIR}" ]; then
  echo "${BASENAME} already installed."
else
  rm -Rf ${BUILD_DIR} ${INSTALL_DIR}

  if [ -d ${SOURCE_DIR} ]; then
    echo "${SOURCE_DIR} already existence"
  else
    echo "============= Retrieving Glog. ================"
    git clone --depth=1 -b ${VERSION} \
      https://github.com/google/glog.git ${SOURCE_DIR}
  fi

  if [ "${INSTALL}" == "true" ]; then
    echo "========== Building Google Glog with libstdc++. ========"
    mkdir -p ${BUILD_DIR}
    pushd ${BUILD_DIR} >/dev/null

    cmake -G "Ninja" \
      -DGFLAGS_NAMESPACE=google \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_CXX_FLAGS="-fPIC -std=c++14" \
      -DCMAKE_INSTALL_PREFIX="../${INSTALL_DIR}" \
      ../${SOURCE_DIR}

    ninja
    ninja install

    popd >/dev/null

  fi

  if [ "${RM_BUILD}" == "true" ]; then
    rm -Rf ${BUILD_DIR}
  fi

  if [ "${RM_SOURCE}" == "true" ]; then
    rm -Rf ${SOURCE_DIR}
  fi

fi
