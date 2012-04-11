#!/bin/sh

PROGRAM=`basename $0`
TARGET=`dirname $0`
SOURCE=$1/weinre.build/out/archives
VERSION=`cat $SOURCE/../version.txt`

#-------------------------------------------------------------------------------
makeDir() {
    if [ -d $1 ] 
    then
        echo x > /dev/null
    else
        mkdir $1
    fi
}

#-------------------------------------------------------------------------------
copyFiles() {

    makeDir builds/$VERSION
    makeDir docs/latest
    
    echo "removing old docs/latest/*"
    rm -rf docs/latest/*
    
    echo "copying archives to $VERSION"
    cp $SOURCE/*-bin.tar.gz builds/$VERSION
    cp $SOURCE/*-bin.zip    builds/$VERSION

    cp $SOURCE/*-doc.tar.gz builds/$VERSION
    cp $SOURCE/*-doc.zip    builds/$VERSION

    cp $SOURCE/*-src.tar.gz builds/$VERSION
    cp $SOURCE/*-src.zip    builds/$VERSION
    
    echo "copying doc to docs/latest"
    cp -R $SOURCE/doc/      docs/latest/
    
    echo "writing $VERSION/.htaccess"
    (
    cat <<EOF
HeaderName  ../index-header.html
AddDescription "binary archive"        *-bin.tar.gz
AddDescription "binary archive"        *-bin.zip
AddDescription "source archive"        *-src.tar.gz
AddDescription "source archive"        *-src.zip
AddDescription "documentation archive" *-doc.tar.gz
AddDescription "documentation archive" *-doc.zip
AddDescription "file hash"             *.MD5
AddDescription "file hash"             *.SHA1
AddDescription "PGP signature"         *.asc
AddDescription "PGP/GPG keys"          KEYS
EOF
    ) > builds/$VERSION/.htaccess
}

#-------------------------------------------------------------------------------
cd $TARGET

#---------------------------------------
if [ -z "$1" ] 
then
   echo "usage: $PROGRAM base-weinre-project-directory"
   exit
fi

#---------------------------------------
if [ -d $SOURCE ]
then
   copyFiles
else
   echo "$PROGRAM: error - directory $SOURCE not found relative to $TARGET"
fi
