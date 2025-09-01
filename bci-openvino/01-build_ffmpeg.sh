#
# ffmpeg
#

BUILD_CC=gcc-14
BUILD_CXX=g++-14

# load build shared settings
MY_DIRNAME=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIRNAME/build_settings.sh

# load oneapi if not loaded
if [ -z $SETVARS_COMPLETED ]; then source /opt/intel/oneapi/setvars.sh; fi

sudo zypper --non-interactive install nasm opencl-headers

cd $SRC_PREFIX
if [ ! -f FFmpeg/.git ]; then
    git clone https://github.com/FFmpeg/FFmpeg.git
fi
pushd FFmpeg
git fetch --all --prune
git checkout $BUILD_FFMPEG_RELEASE

# pic needed for opencv
CC=$BUILD_CC CXX=$BUILD_CXX ./configure --enable-opencl --enable-shared --enable-pic --prefix=$BUILD_INSTALL_PREFIX
make -j$(nproc) || exit 1
sudo make install || exit 1
popd
