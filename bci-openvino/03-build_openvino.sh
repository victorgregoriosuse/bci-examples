#
# openvino
#

# load build shared settings if not loaded
MY_DIRNAME=$(dirname "${BASH_SOURCE[0]}")
if [ -z $BUILD_SHARED_SETTINGS ]; then source $MY_DIRNAME/build_settings.sh; fi

# load oneapi if not loaded
if [ -z $SETVARS_COMPLETED ]; then source /opt/intel/oneapi/setvars.sh; fi

sudo zypper --non-interactive install python311-devel python311-pybind11

cd $BUILD_SRC_PREFIX
git clone https://github.com/openvinotoolkit/openvino.git

pushd openvino
git checkout $BUILD_OPENVINO_RELEASE
git submodule update --init --recursive

# venv needed for build 
python3.11 -m venv $BUILD_PYTHON_VENV
source $BUILD_PYTHON_VENV/bin/activate
pip3 install --no-input -r $BUILD_SRC_PREFIX/openvino/src/bindings/python/wheel/requirements-dev.txt
pip3 install --no-input pybind11-stubgen pre-commit 

# for shellcheck and level-zero
sudo suseconnect -p PackageHub/15.7/x86_64
sudo zypper --non-interactive install ShellCheck level-zero level-zero-devel

rm -rf build && mkdir build && cd build
cmake   -D CMAKE_INSTALL_PREFIX=$BUILD_INSTALL_PREFIX \
        -D CMAKE_BUILD_TYPE=Release \
        -D ENABLE_PYTHON=ON \
        -D PYTHON_EXECUTABLE=$(which python3) \
        -D ENABLE_INTEL_GPU=ON \
        -D CMAKE_C_COMPILER=$BUILD_CC \
        -D CMAKE_CXX_COMPILER=$BUILD_CXX \
        -D OpenCL_HPP_INCLUDE_DIR=/opt/intel/oneapi/$BUILD_ONEAPI_RELEASE/include/ \
        -D CMAKE_POSITION_INDEPENDENT_CODE=ON \
        -D BUILD_SHARED_LIBS=true \
        -D ENABLE_CPPLINT=OFF \
        ..

cmake --build . --config Release -j$(nproc) || exit 1
sudo cmake --build . --target install || exit 1
popd

source $BUILD_INSTALL_PREFIX/setupvars.sh
