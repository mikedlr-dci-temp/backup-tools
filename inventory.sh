#!/bin/sh

#security - according to GNU find this is the "insecure" version because 
#underlying directories could change
#the implication is that if we run this on someone else's directory
#we could checksum a file that wasn't there at the beginning
#e.g. 
#  start find, see a file called "this"
#  hacker changes file to be symlink to sekretstuff/sekret-file
#  we checksum  sekretstuff/sekret-file
#  hacker with read access to our checksum file now verifies 
#  that sekret-file matches another file he already knows
# thus, you should normally keep your checksum files private.

#N.B. we don't see that as a major risk.  

set -e 
TEMPFILE=`mktemp`
( echo inventoryfile-0 directory: at `date` `pwd` ) > $TEMPFILE
cd $1
find . -type f -exec sha384sum {} + | sort -k 2 >> $TEMPFILE
cat $TEMPFILE 
echo -----------------------------------------------
echo inventory checksum `sha384sum $TEMPFILE | sed 's/ .*//'`
