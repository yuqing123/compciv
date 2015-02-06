dirname=$(date '+%Y-%m-%d_%H00')
dir="data-hold/scrapes/$dirname"
mkdir -p $dir
jobcodes=$(cat data-hold/OccupationalSeries.xml | grep -oE 'JobFamily>\b[0-9]{4}\b<' | grep -oE '[0-9]+' | sort | uniq)
cd $dir


for jobcode in $jobcodes; do
	url="https://data.usajobs.gov/api/jobs?page=1&NumberOfJobs=250&series"
	fname="$jobcode-1.json"
	curl -s "$url=$jobcode" -o $fname
	echo $fname
        total_pages=$(cat $fname | jq -r '.Pages')

	for pnum in $(seq 2 $total_pages); do
		url="https://data.usajobs.gov/api/jobs?page=$pnum&NumberOfJobs=250&series"
		fname="$jobcode-$pnum.json"
		curl -s "$url=$jobcode" -o "$fname"
                echo $fname
	done
done
