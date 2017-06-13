# default vars
CONFIGURATION="Debug"

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

# clean project
xcodebuild clean -workspace $WORKSPACE.xcworkspace -scheme $SCHEME | xcpretty

# analyze project
xcodebuild analyze CLANG_ANALYZER_OUTPUT=plist-html CLANG_ANALYZER_OUTPUT_DIR="$(pwd)/clang" -workspace $WORKSPACE.xcworkspace -scheme $SCHEME -destination "${DESTINATION}" -configuration $CONFIGURATION | xcpretty
