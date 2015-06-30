#!/bin/sh
(cd $2; sha384sum -c - )<$1 
