CXX_TAG=gcc
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++

# CXX_TAG=c8
# export CC=/usr/bin/clang-8
# export CXX=/usr/bin/clang++-8

VERSION=v3.18.1 # 版本
BASENAME=protobuf-${VERSION}-${CXX_TAG}

RM_SOURCE="false" # 是否删除源码
RM_BUILD="true"  # 是否删除build文件夹
INSTALL="true"    # 是否编译及安装

SOURCE_DIR=${BASENAME}-source   # 源代码文件夹
BUILD_DIR=${BASENAME}-build    # build文件夹
INSTALL_DIR=${BASENAME}-install # 安装文件夹

if [ -d "${INSTALL_DIR}" ]; then
  echo "${BASENAME} already installed."
else
  rm -Rf ${BUILD_DIR} ${INSTALL_DIR}

  if [ -d ${SOURCE_DIR} ]; then
    echo "${SOURCE_DIR} already existence"
  else
    echo "============= Retrieving Protobuf. ================"
    git clone --depth=1 -b ${VERSION} \
      https://github.com/google/protobuf.git ${SOURCE_DIR}
  fi

  if [ "${INSTALL}" == "true" ]; then
    echo "========== Building Google Protobuf with libstdc++. ========"
    mkdir -p ${BUILD_DIR}
    pushd ${BUILD_DIR} >/dev/null

    cmake -G "Ninja" \
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -Dprotobuf_BUILD_TESTS=OFF \
      -DCMAKE_CXX_FLAGS="-std=c++14" \
      -DCMAKE_INSTALL_PREFIX="../${INSTALL_DIR}" \
      ../${SOURCE_DIR}/cmake

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