d_start='2014-01-01'
d_end='2014-12-31'
days_diff=$(( ( $(date -ud $d_end +'%s') - $(date -ud $d_start +'%s') )/ 60 / 60 / 24 ))

for num in $(seq 0 $days_diff); do
cat data-hold/2014/01/01.html | pup 'li.bf_dom a attr{href}' | cut -d/  -f3 | grep -oE '[[:digit:]]+-' | cut -d- -f1 | sort -n | uniq -c  
date -d "$d_start $num days" +%Y-%m-%d
done
