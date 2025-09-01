#
# opencv
#

# load build shared settings if not loaded
if [ -z $BUILD_SHARED_SETTINGS ]; then source build_settings.sh; fi

# load oneapi if not loaded
if [ -z $SETVARS_COMPLETED ]; then source /opt/intel/oneapi/setvars.sh; fi


sudo zypper --non-interactive install python3-devel python3-numpy-devel libtiff-devel

cd $BUILD_SRC_PREFIX
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

pushd opencv_contrib
git checkout $BUILD_OPENCV_RELEASE
popd

pushd opencv
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