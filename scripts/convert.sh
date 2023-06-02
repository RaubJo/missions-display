#!/usr/bin/env bash

UPLOAD_DIR="$HOME/letters/"
PDF_DIR="$HOME/processed_letters/"
PNG_DIR="$HOME/png_letters/"
LOGFILE="$HOME/log.txt"

SCREEN_SIZE="2160x3840"

checkFolders () {
    if [ ! -d "$PDF_DIR" ]; then
	    mkdir -p "$PDF_DIR"
    fi

    if [ ! -d "$PNG_DIR" ]; then
	    mkdir -p "$PNG_DIR"
    fi
}

convertFiles () {
    cd "$PDF_DIR" || return
    BEGIN_CONVERT=$(date)

    for i in *.pdf; do
        FILENAME="${i%.pdf}.png"
        printf "Converting %s to %s\n" "$i" "$FILENAME"
        convert -density 600 -quality 100 -alpha remove -resize "$SCREEN_SIZE!" "$i" "$PNG_DIR$FILENAME"
    done

    END_CONVERT=$(date)

    printf "# New Conversion Process #\nStart: %s\nEnd: %s\n" "$BEGIN_CONVERT" "$END_CONVERT" | sudo tee -a "$LOGFILE"
}

processFiles () {
    checkFolders

    cd "$UPLOAD_DIR" || return
    echo $(pwd)

    a=1
    for i in *.pdf; do
        NEW=$(printf "%02d.pdf" "$a")
        printf "Found: %s --> %s\n" "$i" "$NEW"
        cp -n -- "$i" "$PDF_DIR$NEW"
        a=$((a+1))
    done

    convertFiles
}

processFiles
