#!/bin/bash
cd $WORK_PATH
mkdir ~/.config/rclone
echo "$RCLONECONFIG" > ~/.config/rclone/rclone.conf
rclone copy -P --drive-chunk-size 256M nk:ccache.tar.gz $WORK_PATH
tar xvzf ccache.tar.gz && rm -rf ccache.tar.gz
