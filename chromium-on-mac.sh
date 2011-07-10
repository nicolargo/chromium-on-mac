#!/bin/bash
#
# Install|Update Chromium Web browser on Mac OS
# 
# Nicolargo
# GPL v3
SCRIPT_VERSION="1.0"

CHROMIUM_URL="http://build.chromium.org/f/chromium/snapshots/Mac"
CHROMIUM_CURRENT_VERSION_FILE="$HOME/.chrome_current_version"
touch $CHROMIUM_CURRENT_VERSION_FILE
CHROMIUM_CURRENT_VERSION=$(cat $CHROMIUM_CURRENT_VERSION_FILE)
echo "Chromium version installed: $CHROMIUM_CURRENT_VERSION"

echo "Checking for update"
CHROMIUM_LATEST_VERSION=$(curl -s -S $CHROMIUM_URL/LATEST)

if [ "$CHROMIUM_CURRENT_VERSION" == "" ] || [ $CHROMIUM_CURRENT_VERSION -lt $CHROMIUM_LATEST_VERSION ]; then
	echo "Latest Chromium version:  $CHROMIUM_LATEST_VERSION"
	echo "Downloading Chromium version $CHROMIUM_LATEST_VERSION"
	curl $CHROMIUM_URL/$CHROMIUM_LATEST_VERSION/chrome-mac.zip > /tmp/chrome-mac.zip
	cd /tmp
	unzip chrome-mac.zip
	cp -R chrome-mac/Chromium.app /Applications/
	rm -Rf /tmp/chrome-mac*
	echo "Chromium version $CHROMIUM_LATEST_VERSION installed"
	echo $CHROMIUM_LATEST_VERSION > $CHROMIUM_CURRENT_VERSION_FILE
else
	echo "No update available, you already have the latest version"
fi
