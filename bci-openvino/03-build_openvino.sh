# openvino

#####################################################################
# settings

BUILD_CC=gcc-13
BUILD_CXX=g++-13

# load build shared settings
MY_DIRNAME=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIRNAME/build_settings.sh

# load oneapi if not loaded
if [ -z $SETVARS_COMPLETED ]; then source /opt/intel/oneapi/setvars.sh; fi

#####################################################################
# requirements

# for python venv used in build
sudo zypper install -y python311-devel python311-pybind11

# for shellcheck, level-zero, and opencl cpp headers
source /etc/os-release
sudo suseconnect -p PackageHub/${VERSION_ID}/x86_64
sudo zypper install -y ShellCheck level-zero level-zero-devel opencl-cpp-headers

#####################################################################
# python venv for build

cd $BUILD_SRC_PREFIX
if [ ! -f openvino/.git ]; then
        git clone https://github.com/openvinotoolkit/openvino.git
fi

if [ -d $BUILD_PYTHON_VENV ]; then
    rm -rf $BUILD_PYTHON_VENV
fi
python3.11 -m venv $BUILD_PYTHON_VENV
source $BUILD_PYTHON_VENV/bin/activate
pip3 install --no-input -r $BUILD_SRC_PREFIX/openvino/src/bindings/python/wheel/requirements-dev.txt
pip3 install --no-input -r $BUILD_SRC_PREFIX/openvino/cmake/developer_package/ncc_naming_style/requirements_dev.txt
pip3 install --no-input pybind11-stubgen pre-commit 

#####################################################################
# build

cd $BUILD_SRC_PREFIX
pushd openvino
git fetch --prune --all
git checkout $BUILD_OPENVINO_RELEASE
git submodule update --init --recursive

rm -rf build && mkdir build && cd build
# -D CMAKE_CXX_FLAGS="-lstdc++fs" 
# -D CMAKE_CXX_FLAGS="-I/usr/include/c++/7" 
# -D CMAKE_CXX_STANDARD=17 \
# -D ENABLE_CLDNN=ON \
cmake   -G "Ninja" \
        -D CMAKE_VERBOSE_MAKEFILE:BOOL=ON \
        -D ENABLE_CLDNN=ON \
        -D CMAKE_INSTALL_PREFIX=$BUILD_INSTALL_PREFIX \
        -D CMAKE_BUILD_TYPE=Release \
        -D ENABLE_PYTHON=ON \
        -D PYTHON_EXECUTABLE=$(which python3) \
        -D ENABLE_INTEL_GPU=ON \
        -D CMAKE_C_COMPILER=$BUILD_CC \
        -D CMAKE_CXX_COMPILER=$BUILD_CXX \
        -D CMAKE_CXX_FLAGS="-I/opt/intel/oneapi/2025.2/include" \
        -D OpenCL_HPP_INCLUDE_DIR=/opt/intel/oneapi/$BUILD_ONEAPI_RELEASE/include/ \
        -D CMAKE_POSITION_INDEPENDENT_CODE=ON \
        -D BUILD_SHARED_LIBS=true \
        -D ENABLE_CPPLINT=OFF \
        ..
cmake --build . --config Release -j$(nproc) || exit 1
sudo cmake --build . --target install || exit 1
popd

# load openvino vars
source $BUILD_INSTALL_PREFIX/setupvars.sh
