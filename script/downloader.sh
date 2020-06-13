#!/usr/bin/env bash

CURRDIR="$PWD"
ICONDIR="${PWD%/*}/kiaflagcons/icons"
TEMPDIR="temp"
TEMPICON_4x3="$( echo "$TEMPDIR/"*"/flags/4x3" )"
TEMPICON_1x1="$( echo "$TEMPDIR/"*"/flags/1x1" )"

LOCATION=$(curl -s https://api.github.com/repos/lipis/flag-icon-css/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/lipis/flag-icon-css/archive/" substr($2, 2, length($2)-3) ".tar.gz"}') \

mkdir -p $TEMPDIR && curl -L "$LOCATION" | tar -xzv --directory $TEMPDIR

rm -rf "$ICONDIR" && mkdir -p "$ICONDIR" && mkdir -p "$ICONDIR/4x3" && mkdir -p "$ICONDIR/1x1"

mv -v  $TEMPICON_4x3/* "$ICONDIR/4x3" && mv -v  $TEMPICON_1x1/* "$ICONDIR/1x1"

rm -rf $TEMPDIR
