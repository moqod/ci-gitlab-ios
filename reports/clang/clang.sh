#### Description: runs xcodebuild with analyze action, then generates json report pls copies html output

# TODO: check for obj-c files existence

# default vars
CONFIGURATION="Debug"

RESULT_FOLDER="ci_report"
CLANG_FOLDER="$RESULT_FOLDER/clang"
CLANG_REPORTS_FOLDER="$RESULT_FOLDER/clang/reports"
CLANG_JSON_SUMMARY_FOLDER="$RESULT_FOLDER/clang/json"
CLANG_STATIC_FOLDER="ci/reports/clang/static"

# parse parameters
while getopts "s:w:t:d:c:" option; do
    case "${option}" in
        s) SCHEME=${OPTARG};;
        w) WORKSPACE=${OPTARG};;
        t) TARGET=${OPTARG};;
        d) DESTINATION=${OPTARG};;
        c) CONFIGURATION=${OPTARG};;
    esac
done

# TODO: validate parameters

# deal with pods
if [ -f "Podfile" ]
then
    pod install LANG=en_US.UTF-8
fi

# clean project
xcodebuild clean -workspace $WORKSPACE.xcworkspace -scheme $SCHEME | xcpretty

# analyze project
xcodebuild analyze CLANG_ANALYZER_OUTPUT=plist-html CLANG_ANALYZER_OUTPUT_DIR="$(pwd)/clang" -workspace $WORKSPACE.xcworkspace -scheme $SCHEME -destination "${DESTINATION}" -configuration $CONFIGURATION | xcpretty

# create report folders
if [ ! -d $CLANG_REPORTS_FOLDER ]; then
    mkdir -p $CLANG_REPORTS_FOLDER
fi

if [ ! -d $CLANG_JSON_SUMMARY_FOLDER ]; then
    mkdir -p $CLANG_JSON_SUMMARY_FOLDER
fi

# copy result html files
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

# copy static files
cp -R $CLANG_STATIC_FOLDER/* $CLANG_FOLDER
