#!/bin/bash
cd $WORK_PATH
#mkdir -p /home/navin/.config
#mkdir -p /home/navin/.config/rclone
#printf $RCLONE_CONFIG > /home/navin/.config/rclone/rclone.conf
#cat /home/navin/.config/rclone/rclone.conf
rclone copy --drive-chunk-size 256M nk:/ccache.tar.gz $WORK_PATH/ -P
tar xvzf ccache.tar.gz && rm -rf ccache.tar.gz
