#
# build tools
#

# load build shared settings if not loaded
if [ -z $BUILD_SHARED_SETTINGS ]; then source build_settings.sh; fi

# load oneapi if not loaded
if [ -z $SETVARS_COMPLETED ]; then source /opt/intel/oneapi/setvars.sh; fi

sudo zypper --non-interactive install git cmake make gcc14 gcc14-c++ clang14 clang14-devel ccache

#
# intel onapi
#

sudo zypper addrepo https://yum.repos.intel.com/oneapi oneAPI
sudo rpm --import https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB

sudo zypper --non-interactive install intel-oneapi-base-toolkit intel-oneapi-mkl
# source /opt/intel/oneapi/setvars.sh