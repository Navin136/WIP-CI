#!/bin/bash
export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
export CCACHE_DIR=$WORK_PATH/ccache
export CCACHE_COMPRESS=true
echo "Variable export success !!!" || { echo "Failed in env setup !!!" && exit 1; }
