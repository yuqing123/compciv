cd data-hold/names-nationwide
cut -d, -f1,2 yob$2.txt > f0.tmp
cut -d, -f1,2 yob$1.txt > f1.tmp
grep -F -x -v -f f0.tmp f1.tmp | sort
