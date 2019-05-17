awk '!/^($|#)/ { print }'  emoji-test.txt  | cut -f 2 -d ";" | cut -f 8- -d " " | sed "s/ /,/;s/://;s/ /_/g" > filtered.txt

