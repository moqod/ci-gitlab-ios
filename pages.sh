#### Description: Copies needed artifacts into public folder

# vars
PUBLIC_FOLDER="public"
RESULT_FOLDER="ci_report"

# create folders
if [ ! -d $PUBLIC_FOLDER ]; then
    mkdir -p $PUBLIC_FOLDER
fi

# copy reports into public folder
cp -R $RESULT_FOLDER/ $PUBLIC_FOLDER
