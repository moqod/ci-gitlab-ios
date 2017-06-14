# vars
TEMP_FOLDER="tmp"
CLANG_REPORTS_FOLDER="$TEMP_FOLDER/clang/reports"
CLANG_JSON_SUMMARY_FOLDER="$TEMP_FOLDER/clang/json"
TAILOR_JSON_SUMMARY_FOLDER="$TEMP_FOLDER/tailor/json"

# TODO: check Readme is empty
# TODO: check .gitignore is empty
# TODO: code duplicates


# create folders
if [ ! -d $CLANG_REPORTS_FOLDER ]; then
    mkdir -p $CLANG_REPORTS_FOLDER
fi

if [ ! -d $CLANG_JSON_SUMMARY_FOLDER ]; then
    mkdir -p $CLANG_JSON_SUMMARY_FOLDER
fi

if [ ! -d $TAILOR_JSON_SUMMARY_FOLDER ]; then
    mkdir -p $TAILOR_JSON_SUMMARY_FOLDER
fi

# find & copy static analyzer html response into $CLANG_REPORTS_FOLDER
if find "clang" -mindepth 1 -print -quit | grep -q .; then
    OIFS="$IFS"
    IFS=$'\n'
    FILES=`find clang -name "*.html"`
    for f in $FILES
    do
        filename=$(basename $f)
        cp $f $CLANG_REPORTS_FOLDER/$filename
    done
    IFS="$OIFS"
fi

# produce summary json
if find "$CLANG_REPORTS_FOLDER" -mindepth 1 -print -quit | grep -q .; then
    echo "Producing clang report..."
    python ci/reports/clang/clang_html_parser.py $(pwd)/$CLANG_REPORTS_FOLDER > $CLANG_JSON_SUMMARY_FOLDER/report.json
    echo "Done!"
else
    echo "Seems like there are no Objective-c files..."
fi

# Tailor
echo "Producing Tailor.sh report..."
tailor * -f json > $TAILOR_JSON_SUMMARY_FOLDER/report.json
echo "Done!"
