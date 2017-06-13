# copy needed artifacts into public folder

# vars
CLANG_STATIC_FOLDER="ci/reports/clang/static"
TEMP_FOLDER="tmp"
PUBLIC_FOLDER="public"

# create folders
if [ ! -d $PUBLIC_FOLDER ]; then
    mkdir -p $PUBLIC_FOLDER
fi

# clang
# copy generated files into public folder
cp -R $TEMP_FOLDER/* $PUBLIC_FOLDER

# copy static files
cp -R $CLANG_STATIC_FOLDER/* $PUBLIC_FOLDER
