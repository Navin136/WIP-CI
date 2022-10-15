#!/bin/bash
repo init -u https://github.com/ArrowOS/android_manifest.git -b arrow-12.1 --depth=1 --no-repo-verify -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
repo sync --fail-fast -j8 # to sync failed repo if .......
. build/envsetup.sh
lunch arrow_X00T-eng
make api-stubs-docs || echo no problem ## To fix OOM, build by parts
make system-api-stubs-docs || echo no problem
make test-api-stubs-docs || echo no problem
mka bacon -j$(nproc --all) |& tee build.log & sleep 90m
