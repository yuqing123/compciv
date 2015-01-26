cd data-hold/names-by-state
grep $2 $1.TXT | cut -d, -f2,4,5 > name1.tmp
for file in *.TXT
do      
  if [ "$file" != "$1.TXT" ]
  then  
        grep $2 $file | cut -d, -f2,4 > name2.tmp
        grep -F -v -f name2.tmp name1.tmp > name3.tmp
        mv name3.tmp name1.tmp 
  fi
done
cat name1.tmp
