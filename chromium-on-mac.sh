#!/bin/bash
#
# Install|Update Chromium Web browser on Mac OS
# 
# Nicolargo
# GPL v3
SCRIPT_VERSION="1.1"

CHROMIUM_URL="http://build.chromium.org/f/chromium/snapshots/Mac"
CHROMIUM_INSTALL_PATH="/Applications/"
CHROMIUM_CURRENT_VERSION_FILE="$CHROMIUM_INSTALL_PATH/Chromium.app/Contents/Info.plist"
CHROMIUM_CURRENT_VERSION=$(cat $CHROMIUM_CURRENT_VERSION_FILE | grep -A 1 SVNRevision | tail -1 | sed -e 's/<[^>]*>//g' | tr -d '\011')

echo "Chromium version installed: $CHROMIUM_CURRENT_VERSION"
echo "Checking for update"
CHROMIUM_LATEST_VERSION=$(curl -s -S $CHROMIUM_URL/LATEST)

if [ "$CHROMIUM_CURRENT_VERSION" == "" ] || [ $CHROMIUM_CURRENT_VERSION -lt $CHROMIUM_LATEST_VERSION ]; then
	echo "Latest version of Chromium will be installed"
	echo "Checking if Chromium is running"
	if [ `ps -A | grep Chromium | wc -l` != 1 ]; then
		echo "ERROR : Chromium must be closed before install new version"
		exit 1
	fi
	
	echo "Latest Chromium version:  $CHROMIUM_LATEST_VERSION"
	echo "Downloading Chromium version $CHROMIUM_LATEST_VERSION"
	curl $CHROMIUM_URL/$CHROMIUM_LATEST_VERSION/chrome-mac.zip > /tmp/chrome-mac.zip
	cd /tmp
	unzip chrome-mac.zip
	rm -rf $CHROMIUM_INSTALL_PATH/Chromium.app
	cp -R chrome-mac/Chromium.app $CHROMIUM_INSTALL_PATH
	rm -Rf /tmp/chrome-mac*
	echo "Chromium version $CHROMIUM_LATEST_VERSION installed"
else
	echo "No update available, you already have the latest version"
fi
