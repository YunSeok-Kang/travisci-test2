#! /bin/sh

PROJECT_PATH=$(pwd)/$UNITY_PROJECT_PATH
UNITY_BUILD_DIR=$(pwd)/Build
LOG_FILE=$UNITY_BUILD_DIR/unity-win.log

returnLicense() {
    echo "Return license"

/Applications/Unity/Unity.app/Contents/MacOS/Unity \
        -batchmode \
        -returnlicense \
        -quit
}

activateLicense() {
    echo "Activate Unity"

/Applications/Unity/Unity.app/Contents/MacOS/Unity \
        -username ${UNITY_USER} \
        -password ${UNITY_PWD} \
        -batchmode \
        -noUpm \
        -quit
}

activateLicense

ERROR_CODE=0
echo "Items in project path ($PROJECT_PATH):"
ls "$PROJECT_PATH"


echo "Building project for Windows..."
mkdir $UNITY_BUILD_DIR
/Applications/Unity/Unity.app/Contents/MacOS/Unity \
  -batchmode \
  -silent-crashes \
  -logFile \
  -projectPath "$PROJECT_PATH" \
  -executeMethod ProjectBuilder.PerformPCBuildClient \
  -quit \
  | tee "$LOG_FILE"
  
returnLicense
  
if [ $? = 0 ] ; then
  echo "Building Windows exe completed successfully."
  ERROR_CODE=0
else
  echo "Building Windows exe failed. Exited with $?."
  ERROR_CODE=1
fi

#echo 'Build logs:'
#cat $LOG_FILE

ls "$PROJECT_PATH"
ls "$PROJECT_PATH/Build"

echo "Finishing with code $ERROR_CODE"
exit $ERROR_CODE
