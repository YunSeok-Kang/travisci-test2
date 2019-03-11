#! /bin/sh

# See https://unity3d.com/get-unity/download/archive
# to get download URLs
UNITY_DOWNLOAD_CACHE="$(pwd)/unity_download_cache"

# 2017.2.0f3
#UNITY_OSX_PACKAGE_URL="https://download.unity3d.com/download_unity/46dda1414e51/MacEditorInstaller/Unity-2017.2.0f3.pkg"
#UNITY_WINDOWS_TARGET_PACKAGE_URL="https://beta.unity3d.com/download/46dda1414e51/MacEditorTargetInstaller/UnitySetup-Windows-Support-for-Editor-2017.2.0f3.pkg"

# Android Settings
androidBuildToolsVersion="25.0.2"
androidPlatformVerion="android-23"

# 2017.3.0f3
UNITY_OSX_PACKAGE_URL="https://download.unity3d.com/download_unity/a9f86dcd79df/MacEditorInstaller/Unity-2017.3.0f3.pkg"
UNITY_WINDOWS_TARGET_PACKAGE_URL="https://download.unity3d.com/download_unity/a9f86dcd79df/MacEditorTargetInstaller/UnitySetup-Windows-Support-for-Editor-2017.3.0f3.pkg"
UNITY_ANDROID_TARGET_PACKAGE_URL="https://download.unity3d.com/download_unity/a9f86dcd79df/MacEditorTargetInstaller/UnitySetup-Android-Support-for-Editor-2017.3.0f3.pkg"

# Downloads a file if it does not exist
download() {

	URL=$1
	FILE=`basename "$URL"`
	
	# Downloads a package if it does not already exist in cache
	if [ ! -e $UNITY_DOWNLOAD_CACHE/`basename "$URL"` ] ; then
		echo "$FILE does not exist. Downloading from $URL: "
		mkdir -p "$UNITY_DOWNLOAD_CACHE"
		curl -o $UNITY_DOWNLOAD_CACHE/`basename "$URL"` "$URL"
	else
		echo "$FILE Exists. Skipping download."
	fi
}

# Downloads and installs a package from an internet URL
install() {
	PACKAGE_URL=$1
	download $1

	echo "Installing `basename "$PACKAGE_URL"`"
	sudo installer -dumplog -package $UNITY_DOWNLOAD_CACHE/`basename "$PACKAGE_URL"` -target /
}

echo "executing: brew update"
brew update

echo "Contents of Unity Download Cache:"
ls $UNITY_DOWNLOAD_CACHE

echo "Installing Unity..."
install $UNITY_OSX_PACKAGE_URL
install $UNITY_WINDOWS_TARGET_PACKAGE_URL
install $UNITY_ANDROID_TARGET_PACKAGE_URL

# android build environment
echo "executing: brew cask install caskroom/versions/java8"
brew cask install caskroom/versions/java8
echo "executing: export JAVA_HOME=$(/usr/libexec/java_home)"
export JAVA_HOME=$(/usr/libexec/java_home)

echo "executing: brew cask install android-sdk"
brew cask install android-sdk
echo "executing: export ANDROID_SDK_ROOT=\"/usr/local/share/android-sdk\""
export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"

echo "executing: brew cask install android-ndk"
brew cask install android-ndk
echo "executing: export ANDROID_NDK_HOME=\"/usr/local/share/android-ndk\""
export ANDROID_NDK_HOME="/usr/local/share/android-ndk"

echo "executing: sdkmanager --update"
yes y | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager --update
#yes y | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager "build-tools;${androidBuildToolsVersion}" "platform-tools" "platforms;${androidPlatformVerion}"
yes y | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager "build-tools;${androidBuildToolsVersion}" "platform-tools" "platforms;${androidPlatformVerion}"


