#!/bin/bash

OUT=$2
IN=$1

# /printer = bigger
# /ebook = smaller

gs \
    -sOutputFile=${OUT} \
    -sDEVICE=pdfwrite \
    -dNOPAUSE \
    -dBATCH  \
    -dPDFSETTINGS=/printer \
    ${IN}
