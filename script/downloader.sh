#!/usr/bin/env bash

CURRDIR="${PWD}"
ICONDIR="${PWD%/*}/kiaflagcons/icons"
TEMPDIR="temp"

# Create temporary directory.
mkdir --parents "${TEMPDIR}"

# Reset current icon directories.
rm --force --recursive "${ICONDIR}"
mkdir --parents "${ICONDIR}"
mkdir --parents "${ICONDIR}/4x3"
mkdir --parents "${ICONDIR}/1x1"

# Create download link.
FIC_VERSION=$(curl --silent https://api.github.com/repos/lipis/flag-icon-css/releases/latest \
| grep "tag_name" \
| awk '{print "" substr($2, 2, length($2)-3)}')

FIC_DOWNLOAD_LINK="https://github.com/lipis/flag-icon-css/archive/${FIC_VERSION}.tar.gz"

# Setup paths.
FIC_TARGZ="kiaflagcons.tar.gz"
TEMPICON_4x3="./${TEMPDIR}/flag-icon-css-${FIC_VERSION}/flags/4x3"
TEMPICON_1x1="./${TEMPDIR}/flag-icon-css-${FIC_VERSION}/flags/1x1"

# Download.
wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 \
--tries 0 --no-dns-cache --output-document "${FIC_TARGZ}" "${FIC_DOWNLOAD_LINK}"

tar --extract --gzip --file "${FIC_TARGZ}" --directory "./${TEMPDIR}"

# Delete downloaded tar.gz
rm "${FIC_TARGZ}"

# Remove current icons.
rm --force --recursive "${ICONDIR}/4x3"
rm --force --recursive "${ICONDIR}/1x1"

# Move files from temporary directory to main directory.
mv "${TEMPICON_4x3}" "${ICONDIR}"
mv "${TEMPICON_1x1}" "${ICONDIR}"

# Delete temporary folder.
rm --force --recursive ./${TEMPDIR}
