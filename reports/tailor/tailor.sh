#### Description: performs Tailor.sh analyze

# default vars
RESULT_FOLDER="ci_report"
TAILOR_FOLDER="$RESULT_FOLDER/tailor"
TAILOR_JSON_SUMMARY_FOLDER="$RESULT_FOLDER/tailor/json"
TAILOR_STATIC_FOLDER="ci/reports/tailor/static"

# create folder
if [ ! -d $TAILOR_JSON_SUMMARY_FOLDER ]; then
    echo $TAILOR_JSON_SUMMARY_FOLDER
    mkdir -p $TAILOR_JSON_SUMMARY_FOLDER
fi

# Tailor
echo "Producing Tailor.sh report..."
tailor * --except=brace-style,trailing-whitespace -f json > $TAILOR_JSON_SUMMARY_FOLDER/report.json
echo "Done!"

# copy static files
cp -R $TAILOR_STATIC_FOLDER/* $TAILOR_FOLDER
