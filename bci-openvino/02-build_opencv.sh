#
# opencv
#

BUILD_CC=gcc-14
BUILD_CXX=g++-14

# load build shared settings
MY_DIRNAME=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIRNAME/build_settings.sh

# load oneapi if not loaded
if [ -z $SETVARS_COMPLETED ]; then source /opt/intel/oneapi/setvars.sh; fi

sudo zypper --non-interactive install python3-devel python3-numpy-devel libtiff-devel

cd $BUILD_SRC_PREFIX

if [ ! -f opencv/.git ]; then
    git clone https://github.com/opencv/opencv.git
fi

if [ ! -f opencv_contrib/.git ]; then
    git clone https://github.com/opencv/opencv_contrib.git
fi

pushd opencv_contrib
git fetch --all --prune
git checkout $BUILD_OPENCV_RELEASE
popd

pushd opencv
git fetch --all --prune
git checkout $BUILD_OPENCV_RELEASE

rm -rf build && mkdir build && cd build
cmake   -D CMAKE_BUILD_TYPE=Release  \
        -D CMAKE_INSTALL_PREFIX=$BUILD_INSTALL_PREFIX \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D BUILD_opencv_python3=ON \
        -D CMAKE_C_COMPILER=$BUILD_CC \
        -D CMAKE_CXX_COMPILER=$BUILD_CXX \
        -D CMAKE_POSITION_INDEPENDENT_CODE=ON \
        -D BUILD_SHARED_LIBS=true ..

make -j$(nproc) || exit 1
sudo make install || exit 1
popd
