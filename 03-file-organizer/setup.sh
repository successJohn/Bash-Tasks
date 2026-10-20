mkdir -p messy
for f in photo1.jpg photo2.png notes.txt report.pdf readme.md song.mp3 archive.zip script.sh; do echo "sample $f" > "messy/$f"; done
