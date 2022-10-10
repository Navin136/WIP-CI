#!/bin/bash
repo init --depth=1 --no-repo-verify -u https://github.com/ArrowOS/android_manifest.git -b arrow-12.1 default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
repo sync --fail-fast -j$(nproc --all)
source build/envsetup.sh
lunch arrow_X00TD-eng
timeout 90m make bacon -j$(nproc --all) | tee log.txt
