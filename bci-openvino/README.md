# SLE BCI OpenVINO with Intel oneAPI

Alpha code, not working. Work in progress.

## Build Notes

* gcc7 \
`filesystem: No such file or directory` \
Errors when trying to use /usr/include/c++/7/experimental/filesystem
* gcc14 \
`tbb/blocked_range.h: No such file or directory` \
Unable to buld with /opt/intel/oneapi/2025.2/include/tbb/blocked_range.h
