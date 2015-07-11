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
TEMP=$(getopt -o o:i:c --long output:,input:,check -n 'inventory.sh' -- "$@" )

if [ $? != 0 ] ; then echo "Argument parsing fail; terminating..." >&2 ; exit 1 ; fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$TEMP"

OFILE=""
IFILE=""
CHECK="false"
while true ; do
	case "$1" in
		-c|--check) CHECK="true" ; shift ;;
		-o|--output)
		    if [ "" != "$OFILE" ]
		    then
			echo "Only one output file allowed.  Terminating" >&2
			exit 1
		    fi
		    OFILE=$2; shift 2 ;;
		-i|--input)
		    if [ "" != "$IFILE" ]
		    then
			echo "Only one input file allowed.  Terminating" >&2
			exit 1
		    fi
		    IFILE=$2; shift 2 ;;
		--) shift ; break ;;
		*) echo "Internal error!" ; exit 1 ;;
	esac
done

if [ "" = "$1" ]
then
    echo "must have at least one directory argument to run inventory on" >&2
    exit 1
fi

if [ "false" = "$CHECK" ]
then
    if [ "" != "$IFILE" ]
    then
	echo "cannot give input file when generating inventory" >&2
	exit 1
    fi
fi


if [  "true" = "$CHECK" ]
then
    if [ "" != "$OFILE" ]
    then
	echo "cannot give output file when checking inventory" >&2
	exit 1
    fi
    ( if [ "" = "$IFILE" ]
    then
	head -n-2
    else
	head -n-2 "$IFILE"
    fi )| tail -n+2 | (cd "$1"; sha384sum -c - )
    SHASUMRES=$?
    exit $SHASUMRES
fi

set -e
TEMPFILE=$(mktemp)
( echo inventoryfile-0 at "$(date)" directory: "$(realpath "$1")" ) > "$TEMPFILE"
( cd "$1"
    {   find . -type f -exec sha384sum {} + | sort -k 2
	echo -----------------------------------------------
    } >> "$TEMPFILE"
    #split to two lines to avid readig and writing at the same time
    FOOT="inventory checksum $(sha384sum "$TEMPFILE" | sed 's/ .*//')"
    echo "$FOOT" >>  "$TEMPFILE"
)
if [ "" = "$OFILE" ]
then
   cat "$TEMPFILE"
else
   mv "$TEMPFILE" "$OFILE"
fi
