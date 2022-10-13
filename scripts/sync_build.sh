#!/bin/bash
set -e
msg() {
        curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        -d "disable_web_page_preview=true" \
        -d "parse_mode=html" \
        -d text="$1"
}

file() {
        MD5=$(md5sum "$1" | cut -d' ' -f1)
        curl --progress-bar -F document=@"$1" "https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
        -F chat_id="$CHAT_ID"  \
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html" \
        -F caption=" <b>MD5 Checksum : </b><code>$MD5</code>"
}
ROM_NAME=$(grep epo $CIRRUS_WORKING_DIR/build.sh -m1 | cut -d / -f4)
echo "Building $ROM_NAME"
echo "Current dir is $WORK_PATH"
DEVICE=$(grep unch $CIRRUS_WORKING_DIR/build.sh | cut -d '-' -f1 | cut -d ' ' -f2 | cut -d '_' -f2)
mkdir $WORK_PATH/$ROM_NAME
cd $WORK_PATH/$ROM_NAME
msg "<b>Repo Sync Started</b>%0A<b>To see status: </b><a href='https://cirrus-ci.com/build/$CIRRUS_BUILD_ID'>Click here</a>"
bash -c "$(head $CIRRUS_WORKING_DIR/build.sh -n 4)"  || { echo "Failed to Init and sync repo !!!" && msg "<b>Failed to Init and sync repo !!</b>"  && exit 1; }
msg "<b>Repo Sync Completed :)</b>"
git clone https://github.com/X00T-dev/device_asus_X00T device/asus/X00T --depth=1  || { echo "Failed to clone device tree !!!" && msg "<b>Failed to clone device tree !!</b>" && exit 1; }
git clone https://github.com/X00T-dev/vendor_asus vendor/asus --depth=1 || { echo "Failed to clone vendor tree !!!" && msg "<b>Failed to clone vendor tree !!</b>" && exit 1; }
git clone https://github.com/X00T-dev/kernel_asus_sdm660_Arrow kernel/asus/sdm660 --depth=1 || { echo "Failed to clone kernel tree !!!" && msg "<b>Failed to clone kernel tree !!</b>"  && exit 1; }
export USE_CCACHE=1
export CCACHE_EXEC=$(which ccache)
export CCACHE_DIR=$WORK_PATH/ccache
export CCACHE_COMPRESS=true
ccache -M 10G
ccache -z
pwd
bash -c "$(tail $CIRRUS_WORKING_DIR/build.sh -n 3)" || { echo "Failed to Start build !!!" && msg "<b>Failed to Start build !!</b>" && exit 1; }
