# settings

unset -v BUILD_SHARED_SETTINGS

export BUILD_SRC_PREFIX=$HOME
export BUILD_INSTALL_PREFIX=/opt/openvino

export BUILD_FFMPEG_RELEASE="release/4.4"
export BUILD_OPENCV_RELEASE="4.12.0"
export BUILD_OPENCL="releases/24.09"
export BUILD_OPENVINO_RELEASE="releases/2025/3"
export BUILD_ONEAPI_RELEASE="2025.2"
export BUILD_PYTHON_VENV="$BUILD_SRC_PREFIX/openvino-venv"

# Check and add to PATH
if [[ ":$PATH:" != *":$BUILD_INSTALL_PREFIX/bin:"* ]]; then
    export PATH="$BUILD_INSTALL_PREFIX/bin:$PATH"
    echo "PATH updated"
fi

# Check and add to LD_LIBRARY_PATH
if [[ ":$LD_LIBRARY_PATH:" != *":$BUILD_INSTALL_PREFIX/lib:"* ]]; then
    export LD_LIBRARY_PATH="$BUILD_INSTALL_PREFIX/lib:$LD_LIBRARY_PATH"
    echo "LD_LIBRARY_PATH updated"
fi

# Check and add to PKG_CONFIG_PATH
if [[ ":$PKG_CONFIG_PATH:" != *":$BUILD_INSTALL_PREFIX/lib/pkgconfig:"* ]]; then
    export PKG_CONFIG_PATH="$BUILD_INSTALL_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
    echo "PKG_CONFIG_PATH updated"
fi

# Check and add to C_INCLUDE_PATH
if [[ ":$C_INCLUDE_PATH:" != *":$BUILD_INSTALL_PREFIX/include:"* ]]; then
    export C_INCLUDE_PATH="$BUILD_INSTALL_PREFIX/include:$C_INCLUDE_PATH"
    echo "C_INCLUDE_PATH updated"
fi

# Check and add to CPLUS_INCLUDE_PATH
if [[ ":$CPLUS_INCLUDE_PATH:" != *":$BUILD_INSTALL_PREFIX/include:"* ]]; then
    export CPLUS_INCLUDE_PATH="$BUILD_INSTALL_PREFIX/include:$CPLUS_INCLUDE_PATH"
    echo "CPLUS_INCLUDE_PATH updated"
fi

# Check and add to PYTHONPATH
if [[ ":$PYTHONPATH:" != *":$BUILD_INSTALL_PREFIX/python:"* ]]; then
    export PYTHONPATH="$BUILD_INSTALL_PREFIX/python:$PYTHONPATH"
    echo "PYTHONPATH updated"
fi

# Check and add to MANPATH
if [[ ":$MANPATH:" != *":$BUILD_INSTALL_PREFIX/share/man:"* ]]; then
    export MANPATH="$BUILD_INSTALL_PREFIX/share/man:$MANPATH"
    echo "MANPATH updated"
fi

export BUILD_SHARED_SETTINGS=1
