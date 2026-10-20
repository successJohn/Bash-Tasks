mkdir -p photos
for n in 0001 0002 0003; do echo "img $n" > "photos/IMG_$n.JPG"; done
echo "img with space" > "photos/IMG_0004 final.JPG"
echo "keep me" > photos/notes.txt
