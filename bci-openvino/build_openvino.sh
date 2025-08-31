
# settings

BUILD_CC=gcc-14
BUILD_CXX=g++-14
SRC_PREFIX=$HOME
INSTALL_PREFIX=/opt/openvino

FFMPEG_RELEASE="release/4.4"
OPENCV_RELEASE="4.12.0"
OPENVINO_RELEASE="releases/2025/3"
ONEAPI_RELEASE="2025.2"

export PATH=$INSTALL_PREFIX/bin:$PATH
export LD_LIBRARY_PATH=$INSTALL_PREFIX/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$INSTALL_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH
export C_INCLUDE_PATH=$INSTALL_PREFIX/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$INSTALL_PREFIX/include:$CPLUS_INCLUDE_PATH
export PYTHONPATH=$INSTALL_PREFIX/python:$PYTHONPATH
export MANPATH=$INSTALL_PREFIX/share/man:$MANPATH

#
# build tools
#

sudo zypper --non-interactive install git cmake make gcc14 gcc14++

#
# intel onapi
#

sudo zypper addrepo https://yum.repos.intel.com/oneapi oneAPI
sudo rpm --import https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB

sudo zypper --non-interactive install intel-oneapi-base-toolkit intel-oneapi-mkl

source /opt/intel/oneapi/setvars.sh

#
# ffmpeg
#

sudo zypper --non-interactive install nasm opencl-headers

cd $SRC_PREFIX
git clone https://github.com/FFmpeg/FFmpeg.git
pushd FFmpeg
git checkout release/4.4

# pic needed for opencv
CC=$BUILD_CC CXX=$BUILD_CXX ./configure --enable-opencl --enable-shared --enable-pic --prefix=$INSTALL_PREFIX
make -j$(nproc) || exit 1
sudo make install || exit 1
popd

#
# opencv
#

sudo zypper --non-interactive install python3-devel python3-numpy-devel libtiff-devel

cd $SRC_PREFIX
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

pushd opencv_contrib
git checkout $OPENCV_RELEASE
popd

pushd opencv
git checkout $OPENCV_RELEASE

rm -rf build && mkdir build && cd build
cmake   -D CMAKE_BUILD_TYPE=Release  \
        -D CMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D BUILD_opencv_python3=ON \
        -D CMAKE_C_COMPILER=$BUILD_CC \
        -D CMAKE_CXX_COMPILER=$BUILD_CXX \
        -D CMAKE_POSITION_INDEPENDENT_CODE=ON \
        -D BUILD_SHARED_LIBS=true \
        ..

make -j$(nproc) || exit 1
sudo make install || exit 1
popd

#
# openvino
#

sudo zypper --non-interactive install python311-devel python311-pybind11

cd $SRC_PREFIX
git clone https://github.com/openvinotoolkit/openvino.git
pushd openvino
git checkout $OPENVINO_RELEASE
git submodule update --init --recursive

# just needed for build 
python3.11 -m venv $HOME/openvino-venv
source $HOME/openvino-venv/bin/activate
# pip3 install -r ./src/bindings/python/wheel/requirements-dev.txt
# a couple more needed that are not in the .txt
pip3 install --no-input pybind11-stubgen pre-commit setuptools wheel build patchelf

# for shellcheck
sudo suseconnect -p PackageHub/15.7/x86_64
sudo zypper --non-interactive install ShellCheck


rm -rf build && mkdir build && cd build
cmake   -D CMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
        -D CMAKE_BUILD_TYPE=Release \
        -D ENABLE_PYTHON=ON \
        -D PYTHON_EXECUTABLE=$(which python3) \
        -D ENABLE_INTEL_GPU=ON \
        -D CMAKE_C_COMPILER=$BUILD_CC \
        -D CMAKE_CXX_COMPILER=$BUILD_CXX \
        -D OpenCL_HPP_INCLUDE_DIR=/opt/intel/oneapi/compiler/$ONEAPI_RELEASE/include/sycl/backend/ \
        -D CMAKE_POSITION_INDEPENDENT_CODE=ON \
        -D BUILD_SHARED_LIBS=true \
        -D ENABLE_CPPLINT=OFF \
        -D CMAKE_CXX_STANDARD=17 \
        -D CMAKE_CXX_STANDARD_REQUIRED=ON \
        ..

cmake --build . --config Release -j$(nproc) || exit 1
sudo cmake --build . --target install || exit 1
popd

source $INSTALL_PREFIX/setupvars.sh
