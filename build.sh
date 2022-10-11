#!/bin/bash
repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-12.1 --depth=1 --no-repo-verify
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
repo sync --fail-fast -j$(nproc --all) # to sync failed repo if .......
. build/envsetup.sh
lunch arrow_X00T-eng
mka bacon -j$(nproc --all) | tee log.txt & sleep 90m
