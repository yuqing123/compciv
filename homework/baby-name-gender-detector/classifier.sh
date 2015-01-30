for name in "$@"; do
  echo "What's in a $name?"

if [[ "$#" -lt 0 ]]; then
	echo "Please pass in at least one name"
else
datafile='data-hold/namesample.txt'
name_matches=$(cat $datafile | grep "$name,")
m_count=0
f_count=0
for row in $name_matches; do
  babies=$(echo $row | cut -d ',' -f '3')
  if [[ $row =~ ',M,' ]]
    then
      m_count=$((m_count + babies))
    else
      f_count=$((f_count + babies))
      echo 'You should do something here for girl babies'
  fi
done

total_babies=$((m_count + f_count))

if [[ $total_babies -eq 0 ]]; then
  g_and_pct="NA,0"
else
  pct_female=$((100 * f_count / total_babies))

  if [[ $pct_female -ge 50 ]]; then
    g_and_pct="F,$pct_female"
  else
  	pct_male=$((100 - $pct_female))
    g_and_pct="M,$pct_male"
    echo 'You should do something here when boys make up the majority'
  fi
fi

echo "$name,$g_and_pct,$total_babies"
fi
done
