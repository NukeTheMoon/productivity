# !/bin/bash

PROJECT="blog"
TARGET_DIR="desktop"
SUFFIX="_d"
OUTPUT="$TARGET_DIR"/"$PROJECT"_design"$SUFFIX".xml

function post_css {
    postcss $1 --use autoprefixer cssnano --no-map
}

if [ -f $OUTPUT ]; then
    rm $OUTPUT
fi

touch $OUTPUT
cat design-start.xml >> $OUTPUT
printf "<style type='text/css'>\n" >> $OUTPUT
cat lib/glider.min.css >> $OUTPUT
printf "\n" >> $OUTPUT
post_css $TARGET_DIR/blog$SUFFIX.css >> $OUTPUT
printf "\n</style>\n" >> $OUTPUT
printf "<script>\n" >> $OUTPUT
cat lib/glider.min.js >> $OUTPUT
printf "\n" >> $OUTPUT
cat $TARGET_DIR/glider$SUFFIX.js >> $OUTPUT
printf "\n" >> $OUTPUT
cat $TARGET_DIR/loadmore$SUFFIX.js >> $OUTPUT
printf "\n</script>\n" >> $OUTPUT
cat design-end.xml >> $OUTPUT
echo -e "\e[32mWrote to $OUTPUT"
