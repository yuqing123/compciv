mkdir tables
cd data-hold
echo 'case_number|date|location|suspect_status|suspect_weapon|suspects|officers|grand_jury|latitude|longitude|narrative' >../tables/incidents.psv
for file in *.html; do
  cat $file | pup 'table table tr json{}' |
  jq  --raw-output '.[] .children | [ 
    .[0] .children[0] .href, 
    .[0] .children[0] .text, 
    .[1] .text ,
    .[2] .text,
    .[3] .text,
    .[4] .text,
    .[5] .text,
    .[6] .text,
    .[7] .text
  ] | @csv' > $file.txt

        sed 's/","/|/g' $file.txt > $file.tmp
        sed -E 's/(,"|")//g' $file.tmp > $file.tmp1
        # rm -rf $file.tmp $file.txt
    
    cat  $file.tmp1|grep -v Location | while read line; do
        address=`echo $line | cut -d\| -f 3| tr ' ' '+'`
        url="https://maps.googleapis.com/maps/api/geocode/json?address=$address&components=administrative_area:TX|country:US"
        curl -o tmp.json $url
        lat=`cat tmp.json | jq --raw-output '.results[0] .geometry .location .lat'`
                lng=`cat tmp.json | jq --raw-output '.results[0] .geometry .location .lng'`
                content=`echo $line | cut -d\| -f 2,3,4,5,6,7,8`
                echo -n "$content|$lat|$lng|" >>../tables/incidents.psv
                pdffile=`echo $line | cut -d\| -f 1|sed -e "s/^.*\///g"`
                pdftotext -layout ./pdfs/$pdffile tmp.txt
                cat tmp.txt|tr [:space:] ' ' >>../tables/incidents.psv
                echo "" >>../tables/incidents.psv
        done

done

cd ..
cd tables
echo 'case_number|date|suspect_weapon|suspect_killed|last_name|first_name|race|gender'>officers.psv
cat incidents.psv|grep -v location |while read line; do
    officers=$(echo -n $line|awk -F\| '{print $7}')
    echo $officers|sed -e "s/\/[MF] /\0\n/g"|while read line2; do
        aa=$(echo -n $line|cut -d\| -f 1,2,5)
        echo -n $aa >>officers.psv
    status=$(echo -n $line|awk -F\| '{print $4}')
    if [ "$status" == "Deceased" ]; then
       echo -n "|True|">>officers.psv
    else
       echo -n "|False|">>officers.psv
    fi
    echo $line2|sed -e "s/, /\|/g" -e "s/ /\|/g" -e "s/\//\|/g">>officers.psv
    done
done

#suspects
echo 'case_number|date|suspect_weapon|last_name|first_name'>suspects.psv
cat incidents.psv|grep -v location |while read line; do
   suspects=$(echo -n $line|awk -F\| '{print $6}')
   echo $suspects|sed -e "s/\/[MF] /\0\n/g"|while read line2; do
       aa=$(echo -n $line|cut -d\| -f 1,2,5)
       echo -n $aa>>suspects.psv
       echo "|$line2"|sed -e "s/ [A-Z]\/[MF]//g" -e "s/, /\|/g">>suspects.psv
   done
done


