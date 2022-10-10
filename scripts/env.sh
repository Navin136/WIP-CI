#!/bin/bash
export ROM_NAME=$(grep epo $CIRRUS_WORKING_DIR/build.sh -m1 | cut -d / -f4)
export DEVICE=$(grep unch $CIRRUS_WORKING_DIR | cut -d '-' -f1 | cut -d ' ' -f2 | cut -d '_' -f2)
export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
export CCACHE_DIR=$WORK_PATH/ccache
export CCACHE_COMPRESS=true
