CXX_TAG=gcc

BUILD_CONCURRENCY=$(nproc --all) # 指定编译使用的线程数量
BOOST_TOOLSET="gcc"
BOOST_CFLAGS="-fPIC -std=c++14 -DBOOST_ERROR_CODE_HEADER_ONLY"

VERSION=1.72.0
BASENAME="boost-${VERSION}-${CXX_TAG}"

RM_SOURCE="false" # 是否删除源码
INSTALL="true"    # 是否编译及安装

SOURCE_DIR=${BASENAME}-source   # 源代码文件夹
INSTALL_DIR=${BASENAME}-install # 安装文件夹

if [ "${INSTALL}" == "true" ]; then

  BOOST_PACKAGE_BASENAME=boost_${VERSION//./_} 
  echo ${BOOST_PACKAGE_BASENAME}.tar.gz

  if [ -f ${BOOST_PACKAGE_BASENAME}.tar.gz ]; then
    echo "${BOOST_PACKAGE_BASENAME}.tar.gz already existence"
  else
    echo "Retrieving boost."
    wget "https://boostorg.jfrog.io/artifactory/main/release/${VERSION}/source/${BOOST_PACKAGE_BASENAME}.tar.gz" || true

  fi

  rm -Rf ${SOURCE_DIR} 
  tar -xvzf ${BOOST_PACKAGE_BASENAME}.tar.gz
  mv ${BOOST_PACKAGE_BASENAME} ${SOURCE_DIR}

  pushd ${SOURCE_DIR} >/dev/null

  bash bootstrap.sh \
    --with-toolset=${BOOST_TOOLSET} \
    --prefix=../${INSTALL_DIR} \
    --with-libraries=python,filesystem,system,program_options

  ./b2 toolset="${BOOST_TOOLSET}" cxxflags="${BOOST_CFLAGS}" \
    --prefix="../${INSTALL_DIR}" -j "${BUILD_CONCURRENCY}" install

  popd >/dev/null

  if [ "${RM_SOURCE}" == "true" ]; then
    rm ${BOOST_PACKAGE_BASENAME}.tar.gz
  fi

fi
