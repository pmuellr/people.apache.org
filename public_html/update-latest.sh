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

    makeDir weinre-builds/$VERSION
    makeDir weinre-docs/latest
    
    rm -rf weinre-docs/latest/*
    
    cp $SOURCE/*-bin.tar.gz weinre-builds/$VERSION
    cp $SOURCE/*-bin.zip    weinre-builds/$VERSION

    cp $SOURCE/*-doc.tar.gz weinre-builds/$VERSION
    cp $SOURCE/*-doc.zip    weinre-builds/$VERSION

    cp $SOURCE/*-src.tar.gz weinre-builds/$VERSION
    cp $SOURCE/*-src.zip    weinre-builds/$VERSION
    
    cp -R $SOURCE/doc/      weinre-docs/latest/
    
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
    ) > weinre-builds/$VERSION/.htaccess
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
