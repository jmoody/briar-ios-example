#!/bin/bash
#http://stackoverflow.com/questions/9726316/modifying-the-2nd-match-in-a-utf-16-input-file
#http://backreference.org/2010/05/23/sanitizing-files-with-no-trailing-newline/
#http://stackoverflow.com/questions/11145270/bash-replace-an-entire-line-in-a-text-file


if [ $# != 3 ] ; then
  echo "usage: versioning.bash <CONFIGURATION> <INFOPLIST_FILE> <APP STORE CONFIGURATION>"
  echo "ex.  bash versioning.bash \"${INFOPLIST_FILE}\""
  exit 1
fi

CONFIGURATION="$1"
INFOPLIST_FILE="$2"
APP_STORE_CONFIGURATION="$3"

gitpath=`which git`
#GITREV=`$gitpath rev-parse --short HEAD`
GITDIRTY=`$gitpath status --porcelain | wc -l | tr -d ' '`
if [ $GITDIRTY != 0 ]; then
  echo "INFO: there are uncommited changes"
  if [ "$CONFIGURATION" = "$APP_STORE_CONFIGURATION" ]; then
    echo "ERROR: this is an app store build which cannot have uncommitted changes; exiting 1"
    exit 1
  fi  
fi

PlistBuddyPath=/usr/libexec/PlistBuddy

touchpath=`which touch`

echo "INFO: checking CFBundleShortVersion for correct format..."
CFBundleShortVersionString=$("$PlistBuddyPath" -c "Print CFBundleShortVersionString" "$INFOPLIST_FILE")
num_dots=$((`echo "$CFBundleShortVersionString"|sed 's/[^.]//g'|wc -m`-1))
if [ $num_dots != 2 ]; then
  echo "ERROR: CFBundleShortVersionString *must* be in <major>.<minor>.<maintenance> format:  found $CFBundleShortVersionString"
  exit 1
fi

echo "INFO: found \"${CFBundleShortVersionString}\" which is correctly formated"

echo "INFO: checking CFBundleVersion against the CFBundleShortVersionString..."
CFBundleVersion=$("$PlistBuddyPath" -c "Print CFBundleVersion" "$INFOPLIST_FILE")
if [ "${CFBundleVersion}" != "${CFBundleShortVersionString}" ]; then
  echo "INFO: the bundle version \"${CFBundleVersion}\" is not equal to the short version string \"${CFBundleShortVersionString}\""
  echo "INFO: setting the bundle version to the short version string..."
  "$PlistBuddyPath" -c "Set :CFBundleVersion $CFBundleShortVersionString" "$INFOPLIST_FILE"
else  
  echo "INFO: found \"${CFBundleVersion}\" which matches the CFBundleShortVersionString - nothing to do"
fi

echo "INFO: checking to see if LJSGitShortRevision is set to GIT_SHORT_REVISION"
LJSGitShortRevision=$("$PlistBuddyPath" -c "Print LJSGitShortRevision" "$INFOPLIST_FILE")
#echo "$PlistBuddyPath -c \"Print LJSGitShortRevision\" $INFOPLIST_FILE"
# if the git short revision does not exist, create it
if [ `echo $?` != 0 ];
then
    echo "INFO:  no entry for LJSGitShortRevision in ${INFOPLIST_FILE}, so we create it"
    "$PlistBuddyPath" -c "Add :LJSGitShortRevision string GIT_SHORT_REVISION" "$INFOPLIST_FILE"
elif  [ "${LJSGitShortRevision}" != "GIT_SHORT_REVISION" ];
then
    echo "WARN: found that LJSGitShortRevision = ${LJSGitShortRevision} which is not correct - resetting"
    "$PlistBuddyPath" -c "Set :LJSGitShortRevision GIT_SHORT_REVISION" "$INFOPLIST_FILE"
else  
 echo "INFO:  LJSGitShortRevision is ${LJSGitShortRevision} which is correct"
fi

#echo "INFO: setting the GIT_SHORT_REVISION = ${GITREV} in InfoPlist.h"
#echo "#define GIT_SHORT_REVISION ${GITREV}" > InfoPlist.h
#
#echo "INFO: touching $INFOPLIST_FILE"
#infoplist_tmp="${INFOPLIST_FILE}.bak"
#cp "${INFOPLIST_FILE}" "${infoplist_tmp}"
#rm "${INFOPLIST_FILE}"
#mv "${infoplist_tmp}" "${INFOPLIST_FILE}"
#echo "INFO: done versioning"
