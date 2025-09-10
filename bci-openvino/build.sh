#!/bin/bash

set -x

rm -f build.log
sh ./00-build_requirements.sh | tee -a build.log
sh ./01-build_ffmpeg.sh | tee -a build.log
sh ./02-build_opencv.sh | tee -a build.log
sh ./03-build_openvino.sh | tee -a build.log

exit $?
