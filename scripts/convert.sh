#!/usr/bin/env bash


PDF_DIR="$HOME/letters/"
PNG_DIR="$HOME/png_letters/"

SCREEN_SIZE="2160x3840"

cd "$PDF_DIR" || return

a=1
for i in *.pdf; do
    NEW=$(printf "%02d.pdf" "$a")
    printf "%s\n" "$NEW"
    mv -n -- "$i" "$NEW"
    a=$((a+1))
done

BEGIN_CONVERT=$(date)

for i in *.pdf; do
    FILENAME="${i%.pdf}.png"
    printf "Converting %s to %s\n" "$i" "$FILENAME"
    convert -density 600 -quality 100 -alpha remove -resize "$SCREEN_SIZE!" "$i" "$PNG_DIR$FILENAME"
done

END_CONVERT=$(date)

printf "Start: %s\n End: %s" "$BEGIN_CONVERT" "$END_CONVERT" | sudo tee -a "/home/$USER/convert_log.txt"
