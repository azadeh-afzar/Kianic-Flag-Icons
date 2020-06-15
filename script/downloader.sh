#!/usr/bin/env bash

CURRDIR="$PWD"
ICONDIR="${PWD%/*}/kiaflagcons/icons"
ICON_TARGZ="kiaflagcons.tar.gz"
TEMPDIR="temp"
TEMPICON_4x3="$( echo "$TEMPDIR/"*"/flags/4x3" )"
TEMPICON_1x1="$( echo "$TEMPDIR/"*"/flags/1x1" )"

# Create temporary directory.
mkdir -p $TEMPDIR

# Reset current icon directories.
rm -rf "$ICONDIR"
mkdir -p "$ICONDIR"
mkdir -p "$ICONDIR/4x3"
mkdir -p "$ICONDIR/1x1"

# Create download link.
LOCATION=$(curl -s https://api.github.com/repos/lipis/flag-icon-css/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/lipis/flag-icon-css/archive/" substr($2, 2, length($2)-3) ".tar.gz"}') \

# Download.
curl -L "$LOCATION" > "$ICON_TARGZ"

# Extract
tar -xz --file "$ICON_TARGZ" --directory "./$TEMPDIR"

# Delete downloaded tar.gz
rm "$ICON_TARGZ"

# Move files from temporary directory to main directory.
mv $TEMPICON_4x3/* "$ICONDIR/4x3"
mv $TEMPICON_1x1/* "$ICONDIR/1x1"

# Delete temporary folder.
rm -rf $TEMPDIR
