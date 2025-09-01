#
# ffmpeg
#

# load build shared settings if not loaded
MY_DIRNAME=$(dirname "${BASH_SOURCE[0]}")
if [ -z $BUILD_SHARED_SETTINGS ]; then source $MY_DIRNAME/build_settings.sh; fi

# load oneapi if not loaded
if [ -z $SETVARS_COMPLETED ]; then source /opt/intel/oneapi/setvars.sh; fi

sudo zypper --non-interactive install nasm opencl-headers

cd $SRC_PREFIX
git clone https://github.com/FFmpeg/FFmpeg.git
pushd FFmpeg
git checkout release/4.4

# pic needed for opencv
CC=$BUILD_CC CXX=$BUILD_CXX ./configure --enable-opencl --enable-shared --enable-pic --prefix=$BUILD_INSTALL_PREFIX
make -j$(nproc) || exit 1
sudo make install || exit 1
popd