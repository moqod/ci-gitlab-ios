# copy needed artifacts into public folder

# vars
CLANG_STATIC_FOLDER="ci/reports/clang/static"
TAILOR_STATIC_FOLDER="ci/reports/tailor/static"

TEMP_FOLDER="tmp"
PUBLIC_FOLDER="public"

# create folders
if [ ! -d $PUBLIC_FOLDER ]; then
    mkdir -p $PUBLIC_FOLDER
fi

if [ ! -d $PUBLIC_FOLDER/tailor ]; then
    mkdir -p $PUBLIC_FOLDER/tailor
fi

if [ ! -d $PUBLIC_FOLDER/clang ]; then
    mkdir -p $PUBLIC_FOLDER/clang
fi


## clang
# copy generated files into public folder
cp -R $TEMP_FOLDER/clang/* $PUBLIC_FOLDER/clang

# copy static files
cp -R $CLANG_STATIC_FOLDER/* $PUBLIC_FOLDER/clang

## Tailor
# copy generated files into public folder
cp -R $TEMP_FOLDER/tailor/* $PUBLIC_FOLDER/tailor

# copy static files
cp -R $TAILOR_STATIC_FOLDER/* $PUBLIC_FOLDER/tailor
