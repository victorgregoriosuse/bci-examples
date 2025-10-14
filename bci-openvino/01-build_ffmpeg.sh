# ffmpeg

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

sudo zypper install -y nasm opencl-headers

#####################################################################
# build

cd $SRC_PREFIX
if [ -d FFmpeg ]; then
    pushd FFmpeg && make distclean && popd
else
    git clone https://github.com/FFmpeg/FFmpeg.git
fi
pushd FFmpeg
git fetch --all --prune
git checkout $BUILD_FFMPEG_RELEASE

# pic needed for opencv
./configure --cc=$BUILD_CC --enable-opencl --enable-shared --enable-pic --prefix=$BUILD_INSTALL_PREFIX
make -j$(nproc) || exit 1
sudo make install || exit 1
ldd $(which ffmpeg)
popd
