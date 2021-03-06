#! /bin/sh

PROJECT_PATH=$(pwd)/$UNITY_PROJECT_PATH
UNITY_BUILD_DIR=$(pwd)/Build
LOG_FILE=$UNITY_BUILD_DIR/unity-win.log
RELEASE_DIRECTORY=./release

ERROR_CODE=0

echo "Packaging unity package into release..."
#Preprare release unity package by packing into ZIP
RELEASE_ZIP_FILE=$RELEASE_DIRECTORY/$PROJECT_NAME-v$TRAVIS_TAG.zip

mkdir -p $RELEASE_DIRECTORY

echo "Preparing release for version: $TRAVIS_TAG"
cp -r $PROJECT_PATH/Build $RELEASE_DIRECTORY

echo "Files in release directory:"
ls $RELEASE_DIRECTORY

zip -6 -r $RELEASE_ZIP_FILE $RELEASE_DIRECTORY

echo "Release zip package ready. Zipinfo:"
zipinfo $RELEASE_ZIP_FILE
	

#echo 'Build logs:'
#cat $LOG_FILE

echo "Export finished with code $ERROR_CODE"
exit $ERROR_CODE
