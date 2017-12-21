#!/bin/sh

DEBNAM=gambas3
DEBVER=`grep '^Version' ${DEBNAM}.dsc | tr -cd '[0-9\.\-]'`
DEBTAR="${DEBNAM}_${DEBVER}.debian.tar.xz"

echo "Creating ${DEBTAR}:"

tar -cvJf "${DEBTAR}" --exclude='*.ex' debian

echo "Updating checksums..."

ORIGVER=`echo ${DEBVER} | cut -d- -f1`
ORIGTAR="${DEBNAM}-${ORIGVER}.tar.gz"
ORIGSIZE=`stat -c %s ${ORIGTAR}`

DEBSIZE=`stat -c %s ${DEBTAR}`

echo " `sha256sum ${ORIGTAR} | cut -d' ' -f1` ${ORIGSIZE} ${DEBNAM}_${ORIGVER}.orig.tar.gz" > checksums.txt
echo " `sha256sum ${DEBTAR} | cut -d' ' -f1` ${DEBSIZE} ${DEBTAR}" >> checksums.txt
echo "Checksums-Sha1:" >> checksums.txt
echo " `sha1sum ${ORIGTAR} | cut -d' ' -f1` ${ORIGSIZE} ${DEBNAM}_${ORIGVER}.orig.tar.gz" >> checksums.txt
echo " `sha1sum ${DEBTAR} | cut -d' ' -f1` ${DEBSIZE} ${DEBTAR}" >> checksums.txt
echo "Files:" >> checksums.txt
echo " `md5sum ${ORIGTAR} | cut -d' ' -f1` ${ORIGSIZE} ${DEBNAM}_${ORIGVER}.orig.tar.gz" >> checksums.txt
echo " `md5sum ${DEBTAR} | cut -d' ' -f1` ${DEBSIZE} ${DEBTAR}" >> checksums.txt

lead='^Checksums-Sha256:$'
sed -i "/$lead/,$ { /$lead/{p; r checksums.txt
        }; d }"  ${DEBNAM}.dsc

rm checksums.txt
cp "${DEBNAM}-${ORIGVER}.tar.gz" "${DEBNAM}_${ORIGVER}.orig.tar.gz"