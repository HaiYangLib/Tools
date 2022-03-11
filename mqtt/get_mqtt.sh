# ==============================================================================
CXX_TAG=c8
export CC=/usr/bin/clang-8
export CXX=/usr/bin/clang++-8

MQTT_VERSION=v1.3.9
MQTT_BASENAME=mqtt-${MQTT_VERSION}-${CXX_TAG}
MQTT_RM_SOURCE="false" # 是否删除源码

# libstdcxx 版本
MQTT_LIBSTDCXX_INCLUDE=${PWD}/${MQTT_BASENAME}-libstdcxx-install/include
MQTT_LIBSTDCXX_LIBPATH=${PWD}/${MQTT_BASENAME}-libstdcxx-install/lib

if [[ -d "${MQTT_BASENAME}-libcxx-install" && -d "${MQTT_BASENAME}-libstdcxx-install" ]]; then
  echo "${MQTT_BASENAME} already installed."
else
  rm -Rf \
    ${MQTT_BASENAME}-libstdcxx-build \
    ${MQTT_BASENAME}-libstdcxx-install

  if [ "${MQTT_RM_SOURCE}" == "true" ]; then
    rm -Rf ${MQTT_BASENAME}-source
  fi

  echo "Retrieving MQTT."
  git clone --depth=1 -b ${MQTT_VERSION} https://github.com/eclipse/paho.mqtt.c.git ${MQTT_BASENAME}-source

  echo "====================Building Google MQTT with libstdc++.======================"

  mkdir -p ${MQTT_BASENAME}-libstdcxx-build

  pushd ${MQTT_BASENAME}-libstdcxx-build >/dev/null

  cmake -G "Ninja" \
    -DCMAKE_INSTALL_PREFIX="../${MQTT_BASENAME}-libstdcxx-install" \
    ../${MQTT_BASENAME}-source

  ninja

  ninja install

  popd >/dev/null

  rm -Rf ${MQTT_BASENAME}-libcxx-build ${MQTT_BASENAME}-libstdcxx-build

  if [ "${MQTT_RM_SOURCE}" == "true" ]; then
    rm -Rf ${MQTT_BASENAME}-source
  fi

fi

echo "====================Building Google Gflag finshed.======================"
