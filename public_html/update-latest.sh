#!/bin/sh

PROGRAM=`basename $0`
TARGET=`dirname $0`
SOURCE=$1/weinre.build/out/archives

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
    makeDir weinre-builds/bin
    makeDir weinre-builds/doc
    makeDir weinre-builds/src
    makeDir weinre-docs/latest
    
    rm -rf weinre-docs/latest/*
    
    cp $SOURCE/*-bin.tar.gz weinre-builds/bin
    cp $SOURCE/*-bin.zip    weinre-builds/bin

    cp $SOURCE/*-doc.tar.gz weinre-builds/doc
    cp $SOURCE/*-doc.zip    weinre-builds/doc

    cp $SOURCE/*-src.tar.gz weinre-builds/src
    cp $SOURCE/*-src.zip    weinre-builds/src
    
    cp -R $SOURCE/doc/      weinre-docs/latest/
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
