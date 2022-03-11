CXX_TAG=gcc
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++

# CXX_TAG=c8
# export CC=/usr/bin/clang-8
# export CXX=/usr/bin/clang++-8

BASENAME=osqp-${CXX_TAG}

RM_SOURCE="false" # 是否删除源码
RM_BUILD="true"   # 是否删除build文件夹

SOURCE_DIR=${BASENAME}-source # 源代码文件夹
BUILD_DIR=${BASENAME}-build   # build文件夹

git clone --recursive https://github.com/oxfordcontrol/osqp ${SOURCE_DIR}

mkdir -p ${BUILD_DIR}
pushd ${BUILD_DIR} >/dev/null

cmake -G "Ninja" \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_CXX_FLAGS="-fPIC -std=c++14" \
  ../${SOURCE_DIR}

ninja
ninja install

popd >/dev/null

if [ "${RM_BUILD}" == "true" ]; then
  rm -Rf ${BUILD_DIR}
fi

if [ "${RM_SOURCE}" == "true" ]; then
  rm -Rf ${SOURCE_DIR}
fi
