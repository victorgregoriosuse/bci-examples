#
# opencl
#
# https://www.intel.com/content/www/us/en/developer/articles/tool/opencl-drivers.html
# 

BUILD_CC=gcc-14
BUILD_CXX=g++-14

# load build shared settings
MY_DIRNAME=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIRNAME/build_settings.sh

# load oneapi if not loaded
if [ -z $SETVARS_COMPLETED ]; then source /opt/intel/oneapi/setvars.sh; fi

cd $BUILD_SRC_PREFIX
if [ ! -f compute-runtime/.git ]; then
        git clone https://github.com/intel/compute-runtime.git
fi

pushd compute-runtime
git fetch --prune --all
git checkout $BUILD_OPENCL_RELEASE

rm -rf build && mkdir build && cd build
cmake   -D CMAKE_INSTALL_PREFIX=$BUILD_INSTALL_PREFIX \
        -D CMAKE_BUILD_TYPE=Release \
        -D CMAKE_C_COMPILER=$BUILD_CC \
        -D CMAKE_CXX_COMPILER=$BUILD_CXX \
        -D CMAKE_POSITION_INDEPENDENT_CODE=ON \
        -D ENABLE_CPPLINT=OFF \
        -D BUILD_SHARED_LIBS=true \
        -D NEO_SKIP_UNIT_TESTS=1 \
        ..

cmake --build . --config Release -j$(nproc) || exit 1
sudo cmake --build . --target install || exit 1
popd

