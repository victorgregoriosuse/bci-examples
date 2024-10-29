#!/bin/bash -x 

# Reference
# https://docs.anaconda.com/miniconda/
# 

# download and install
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3

# load miniconda3 as a test
source ~/miniconda3/bin/activate
conda init --all

# deactivate and remove installer
conda deactivate
rm -f ~/miniconda3/miniconda.sh

exit $?
