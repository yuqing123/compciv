cd data-hold/names-nationwide
cut -d, -f1,2 yob$2.txt > A.tmp
cut -d, -f1,2 yob$1.txt > B.tmp
grep -F -x -v -f A.tmp B.tmp | sort
