# vars
TEMP_FOLDER="tmp"
CLANG_REPORTS_FOLDER="$TEMP_FOLDER/reports"
CLANG_JSON_SUMMARY_FOLDER="$TEMP_FOLDER/json"

# create folders
if [ ! -d $CLANG_REPORTS_FOLDER ]; then
    mkdir -p $CLANG_REPORTS_FOLDER
fi

if [ ! -d $CLANG_JSON_SUMMARY_FOLDER ]; then
    mkdir -p $CLANG_JSON_SUMMARY_FOLDER
fi

# find & copy analyzer html response into $CLANG_REPORTS_FOLDER
OIFS="$IFS"
IFS=$'\n'
FILES=`find clang -name "*.html"`
for f in $FILES
do
    filename=$(basename $f)
    cp $f $CLANG_REPORTS_FOLDER/$filename
done
IFS="$OIFS"

# produce summary json
python ci/reports/clang/clang_html_parser.py $(pwd)/$CLANG_REPORTS_FOLDER > $CLANG_JSON_SUMMARY_FOLDER/report.json
