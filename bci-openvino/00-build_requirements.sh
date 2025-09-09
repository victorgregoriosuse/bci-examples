#
# build tools
#

# load build shared settings
MY_DIRNAME=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIRNAME/build_settings.sh

# needed tools
# sudo zypper --non-interactive install git gcc14 gcc14-c++ clang14 clang14-devel ccache
sudo zypper --non-interactive install git which

# intel requirements
sudo zypper --non-interactive install -t pattern devel_basis
# kernel-devel needed for intel-pti
sudo zypper --non-interactive install cmake kernel-devel

#
# intel oneapi
# https://www.intel.com/content/www/us/en/developer/tools/oneapi/base-toolkit-download.html
# 

sudo zypper addrepo https://yum.repos.intel.com/oneapi oneAPI
sudo rpm --import https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
sudo zypper refresh
# sudo zypper se -s -r oneAPI

sudo zypper --non-interactive install intel-oneapi-base-toolkit intel-oneapi-mkl intel-oneapi-runtime-opencl
sudo zypper se -s -r oneAPI -i

#
# intel datacenter gpu
# https://dgpu-docs.intel.com/driver/installation-lts2.html#sles
#
# not supported yet for sles15sp7

# . /etc/os-release
# VERSION_SP=${VERSION_ID//./sp}
# sudo zypper addrepo -f -r \
#     https://repositories.intel.com/gpu/sles/${VERSION_SP}/lts/2523/unified/intel-gpu-${VERSION_SP}.repo
# sudo rpm --import https://repositories.intel.com/gpu/intel-graphics.key

# computing and media runtimes
# sudo zypper install -y \
#     intel-level-zero-gpu level-zero intel-gsc intel-opencl intel-ocloc \
#     intel-media-driver libigfxcmrt7 libvpl2 libvpl-tools libmfxgen1

# development packages
# sudo zypper install -y \
#     libigdfcl-devel intel-igc-cm libigfxcmrt-devel level-zero-devel

# verification tools
# sudo zypper install -y \
#     clinfo libOpenCL1 libva-utils hwinfo

# load oneapi if not loaded
if [ -z $SETVARS_COMPLETED ]; then source /opt/intel/oneapi/setvars.sh; fi
