# prep build requirements

#####################################################################
# settings

# load build shared settings
MY_DIRNAME=$(dirname "${BASH_SOURCE[0]}")
source $MY_DIRNAME/build_settings.sh

#####################################################################
# global requirements

# intel oneapi requirements
sudo zypper install -y -t pattern devel_basis

# intel oneapi's intel-pti wants kernel-devel
sudo zypper install -y kernel-devel

# gcc13-c++ is in sle-module-hpc
sudo suseconnect -p sle-module-hpc/15.7/x86_64
sudo zypper install -y gcc13 gcc13-c++

# basic tools not covered above
sudo zypper install -y git which cmake

# this could be problematic, lets make sure it is not installed
sudo zypper remove -y ccache

#####################################################################
# intel oneapi
# https://www.intel.com/content/www/us/en/developer/tools/oneapi/base-toolkit-download.html

sudo zypper addrepo https://yum.repos.intel.com/oneapi oneAPI
sudo rpm --import https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
sudo zypper refresh

sudo zypper install -y intel-oneapi-base-toolkit intel-oneapi-mkl intel-oneapi-runtime-opencl
sudo zypper se -s -r oneAPI -i

# load oneapi if not loaded
if [ -z $SETVARS_COMPLETED ]; then source /opt/intel/oneapi/setvars.sh; fi
