#!/bin/bash

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

#N.B. I don't see the above as vulnerabiliy; just an expected feature

# Note that we use `"$@"' to let each command-line parameter expand to a
# separate word. The quotes around `$@' are essential!
# We need TEMP as the `eval set --' would nuke the return value of getopt.
TEMP=`getopt -o o: --long output: \
     -n 'inventory.sh' -- "$@"`

if [ $? != 0 ] ; then echo "Argument parsing fail; terminating..." >&2 ; exit 1 ; fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$TEMP"

OFILE=""

while true ; do
	case "$1" in
		-o|--output)
		    if [ "" != "$OFILE" ]
		    then
			echo "Only one output file allowed.  Terminating" >&2
			exit 1
		    fi
		    OFILE=$2; shift 2 ;;
		--) shift ; break ;;
		*) echo "Internal error!" ; exit 1 ;;
	esac
done

if [ "" = "$1" ]
then
    echo "must have at least one directory argument to run inventory on" >&2
    exit 1
fi

set -e
TEMPFILE=`mktemp`
( echo inventoryfile-0 directory: at `date` `realpath "$1"` ) > $TEMPFILE
( cd $1
    find . -type f -exec sha384sum {} + | sort -k 2 >> $TEMPFILE
    echo ----------------------------------------------- >> $TEMPFILE
    echo inventory checksum `sha384sum $TEMPFILE | sed 's/ .*//'` >> $TEMPFILE 
)
if [ "" = "$OFILE" ]
then
   cat $TEMPFILE
else
   mv $TEMPFILE $OFILE
fi
