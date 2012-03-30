#!/bin/sh

cd `dirname $0`
rsync -v -r -p -t public_html/ people.apache.org:public_html/