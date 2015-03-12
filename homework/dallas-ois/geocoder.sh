#!/bin/bash
cat data-hold/*.html | pup 'td:nth-of-type(3) text{}'> data-hold/input
FILENAME="data-hold/input"
rm -rf locations.psv
output="tables/locations.psv"
echo "location|latitude|longitude|" > $output
cat $FILENAME | while read line
do
	echo ===============
	echo $line
	address=` echo $line | tr ' ' '+'`
	echo $address
	url="https://maps.googleapis.com/maps/api/geocode/json?address=$address&components=administrative_area:TX|country:US"
	echo $url
	curl -o tmp.json $url
	lat=`cat tmp.json | jq --raw-output '.results[0] .geometry .location .lat'`
	lng=`cat tmp.json | jq --raw-output '.results[0] .geometry .location .lng'`
	echo "lat=$lat"
	echo "lng=$lng"
	echo "$line|$lat|$lng" >> $output
done


# curl https://maps.googleapis.com/maps/api/geocode/json?address=895+campus+drive,+stanford,+CA&components=administrative_area:TX|country:US
# curl https://maps.googleapis.com/maps/api/geocode/json?address=895+campus+drive,+stanford,+CA&components=administrative_area:CA|country:US
