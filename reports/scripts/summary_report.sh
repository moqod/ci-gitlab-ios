#### Description: generates summary report :)
## Params:
# b – branch name
# p - project name
# h - commit hash
# m - commit message
# v - bundle version

# properties support : )
PROPERTY_FILE="reports/reports.properties"
function getProperty {
   PROP_KEY=$1
   PROP_VALUE=`cat $PROPERTY_FILE | grep "$PROP_KEY" | cut -d'=' -f2`
   echo $PROP_VALUE
}

# parse parameters
while getopts "b:p:h:m:v:" option; do
    case "${option}" in
        b) BRANCH_NAME=${OPTARG};;
        p) PROJECT_NAME=${OPTARG};;
        h) COMMIT_HASH=${OPTARG};;
        m) COMMIT_MESSAGE=${OPTARG};;
        v) BUNDLE_VERSION=${OPTARG};;
    esac
done

# summary configuration
# SOME=$(getProperty "TAILOR_STATIC_FOLDER")
# echo $SOME

JSON="{\"branch\":\"$BRANCH_NAME\",\
\"project_name\":\"$PROJECT_NAME\",\
\"commit_hash\":\"$COMMIT_HASH\",\
\"commit_message\":\"$COMMIT_MESSAGE\",\
\"bundle_version\":\"$BUNDLE_VERSION\",\
\"reports\":[{\
\"type\":\"clang\",\
\"report_json\":\"/$(getProperty "CLANG_JSON_SUMMARY_FOLDER")/report.json\",\
\"report_html\":\"/$(getProperty "CLANG_FOLDER")/index.html\",\
\"summary\":\"summary\"\
},{\
\"type\":\"jscpd\",\
\"report_json\":\"/$(getProperty "JSCPD_JSON_SUMMARY_FOLDER")/report.json\",\
\"report_html\":\"/$(getProperty "JSCPD_FOLDER")/index.html\",\
\"summary\":\"statistics\"\
}]\
}"

# echo $JSON

python reports/scripts/summary.py $JSON

cp -rf reports/index.html ci_report/
cp -rf reports/static ci_report/
