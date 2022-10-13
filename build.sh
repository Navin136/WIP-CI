#!/bin/bash
repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-12.1 --depth=1 --no-repo-verify -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
repo sync --fail-fast -j8 # to sync failed repo if .......
. build/envsetup.sh
lunch arrow_X00T-eng
mka bacon -j8 |& tee build.log & sleep 95m
