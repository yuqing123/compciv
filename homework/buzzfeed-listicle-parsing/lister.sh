d_start='2014-01-01'
d_end='2014-12-31'
days_diff=$(( ( $(date -ud $d_end +'%s') - $(date -ud $d_start +'%s') )/ 60 / 60 / 24 ))

rm -f temp.txt

for num in $(seq 0 $days_diff); do
  date_path=$(date -d "$d_start $num days" +%Y/%m/%d)
  cat data-hold/${date_path}.html | pup 'li.bf_dom a attr{href}' | cut -d/  -f3 | grep -oE '\b[[:digit:]]{1,3}-' | cut -d- -f1 >> temp.txt
done

cat temp.txt | sort -n | uniq -c | sort -r
