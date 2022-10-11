#!/bin/bash
ROM_NAME=$(grep epo $CIRRUS_WORKING_DIR/build.sh -m1 | cut -d / -f4)
DEVICE=$(grep unch $CIRRUS_WORKING_DIR/build.sh | cut -d '-' -f1 | cut -d ' ' -f2 | cut -d '_' -f2)
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
cd $WORK_PATH/$ROM_NAME
FILENAME=$WORK_PATH/$ROM_NAME/out/target/product/$DEVICE/*$DEVICE*.zip
ZIPNAME=$(echo $FILENAME | cut -d '/' -f 7)
if [ -f $WORK_PATH/$ROM_NAME/out/target/product/$DEVICE/*$DEVICE*.zip ]
then
	msg "<b>Build Completed ....</b>%0A<b>Uploading to Team drive</b>"
	rclone copy -P $WORK_PATH/$ROM_NAME/out/target/product/$DEVICE/*$DEVICE*.zip nk:/$ZIPNAME
	msg "<b>Uploaded Successfully ...</b>%0A<b>Link: </b><code>$(rclone link nk:$ZIPNAME)</code>"
else
	msg "<b>Build Not Completed ....</b>%0A<b>Uploading ccache</b>"
	tar --use-compress-program="pigz -k -1" -cf ccache.tar.gz $WORK_PATH/ccache || { echo "Failed to Compress ccache !!!" && exit 1; } # pigz for faster compressing
	rclone copy -P --drive-chunk-size 256M ccache.tar.gz nk: || { echo "Failed to Upload ccache !!!" && exit 1; } # Upload ccache
fi

