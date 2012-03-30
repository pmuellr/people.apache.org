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
    makeDir $TARGET/weinre-builds/bin
    makeDir $TARGET/weinre-builds/doc
    makeDir $TARGET/weinre-builds/src
    makeDir $TARGET/weinre-docs/latest
    
    rm -rf $TARGET/weinre-docs/latest/*
    
    cp $SOURCE/*-bin.tar.gz $TARGET/weinre-builds/bin
    cp $SOURCE/*-bin.zip    $TARGET/weinre-builds/bin

    cp $SOURCE/*-doc.tar.gz $TARGET/weinre-builds/doc
    cp $SOURCE/*-doc.zip    $TARGET/weinre-builds/doc

    cp $SOURCE/*-src.tar.gz $TARGET/weinre-builds/src
    cp $SOURCE/*-src.zip    $TARGET/weinre-builds/src
    
    cp -R $SOURCE/doc/     $TARGET/weinre-docs/latest/
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
