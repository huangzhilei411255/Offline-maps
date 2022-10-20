#! /bin/bash

# Resolve links - $0 may be a softlink
PRG="$0"
while [ -h "$PRG" ]; do
        ls=`ls -ld "$PRG"`
        link=`expr "$ls" : '.*-> \(.*\)$'`
        if expr "$link" : '.*/.*' > /dev/null; then
                PRG="$link"
        else
                PRG=`dirname "$PRG"`/"$link"
        fi
        done
PRGDIR=`dirname "$PRG"`

#get shell full path
cd $PRGDIR
PRG_FULL_DIR=`pwd -P`
cd - >/dev/null

HTML_REPORT_ROOT=$PRG_FULL_DIR 
backup_file()
{
    [ -f ${1} ] &&    cp -f ${1} ${1}.bak
}

#
# $1 in file
# $2 target file
#

cd $HTML_REPORT_ROOT
time=`date +%s`


ln -s $HTML_REPORT_ROOT  /opt/html_report
