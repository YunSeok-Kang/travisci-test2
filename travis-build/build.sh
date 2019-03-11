#! /bin/sh

PROJECT_PATH=$(pwd)/$UNITY_PROJECT_PATH
UNITY_BUILD_DIR=$(pwd)/Build
LOG_FILE=$UNITY_BUILD_DIR/unity-win.log

ERROR_CODE=0
echo "Items in project path ($PROJECT_PATH):"
ls "$PROJECT_PATH"

export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
export ANDROID_NDK_HOME="/usr/local/share/android-ndk"
export JAVA_HOME=$(/usr/libexec/java_home)

echo "Building project for Android..."
mkdir $UNITY_BUILD_DIR
/Applications/Unity/Unity.app/Contents/MacOS/Unity \
  -batchmode \
  -silent-crashes \
  -logFile \
  -projectPath "$PROJECT_PATH" \
  -executeMethod ProjectBuilder.PerformPCBuildClient \
  #-executeMethod ProjectBuilder.PerformAndroidBuildClient \
  -quit \
  | tee "$LOG_FILE"
  
if [ $? = 0 ] ; then
  echo "Building Windows exe completed successfully."
  ERROR_CODE=0
else
  echo "Building Windows exe failed. Exited with $?."
  ERROR_CODE=1
fi

#echo 'Build logs:'
#cat $LOG_FILE

echo "Finishing with code $ERROR_CODE"
exit $ERROR_CODE
