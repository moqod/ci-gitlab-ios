#### Description: analyzes code duplication using jscpd tool

# default vars
RESULT_FOLDER="ci_report"
JSCPD_FOLDER="$RESULT_FOLDER/jscpd"
JSCPD_JSON_SUMMARY_FOLDER="$RESULT_FOLDER/jscpd/json"
JSCPD_STATIC_FOLDER="ci/reports/jscpd/static"

# create folder
if [ ! -d $JSCPD_JSON_SUMMARY_FOLDER ]; then
    echo $JSCPD_JSON_SUMMARY_FOLDER
    mkdir -p $JSCPD_JSON_SUMMARY_FOLDER
fi

# find dups
jscpd --languages clike,swift --reporter json --output $JSCPD_JSON_SUMMARY_FOLDER/report.json -e "**/Pods/**"

# copy static files
cp -R $JSCPD_STATIC_FOLDER/* $JSCPD_FOLDER
