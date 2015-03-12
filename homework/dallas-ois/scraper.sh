mkdir -p ./data-hold/pdfs
cd data-hold
curl -s -o 2013.html "http://www.dallaspolice.net/ois/ois.html"
curl -O -s "http://www.dallaspolice.net/ois/ois_20[03-12].html"

cd pdfs
cat ../*.html | grep pdf|awk -F\" '{print "curl -s -O http://www.dallaspolice.net"$4}'|grep narrative|sh

