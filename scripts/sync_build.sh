#!/bin/bash
mkdir $WORK_PATH/$ROM_NAME
cd $WORK_PATH/$ROM_NAME
bash -c "$(head $CIRRUS_WORKING_DIR/build.sh -n 4)"
./$CIRRUS_WORKING_DIR/scripts/clone.sh
ccache -M 10G
ccache -z
bash -c "$(tail $CIRRUS_WORKING_DIR/build.sh -n 3)"
