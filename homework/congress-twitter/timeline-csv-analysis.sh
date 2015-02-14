# This assignment is just for readability purposes
username=$1
file="./data-hold/${username}-timeline.csv"
# create data-hold if it doesn't already exist
mkdir -p ./data-hold
# use t to download the tweets in CSV form and save to file
echo "Fetching tweets for $username into $file"
t timeline -n 3200 --csv ${username} > ${file}

# Get the count of lines using csvfix and its order subcommand
# note: another subcommand could be used here, but the point is to use
# csvfix to reduce the file to just the first field, and then count the lines.

# In other words, you cannot just count the number of Tweets with wc alone, 
# because some tweets span multiple lines
count=$(csvfix order -f 1 $file | wc -l)
# The timestamp of the tweet is in the field (i.e. column) named, 'Posted at'
# and the oldest tweet is in the last line
lastdate=$(csvfix order -fn 'Posted at' $file | tail -n 1)
# Echoing some stats about the tweets
echo "Analyzing $count tweets by $1 since $lastdate"

#Top 10 hashtags, case-insensitive, in order of frequency of appearance.
echo "Top 10 hashtags by $username"
csvfix order -fn 'Text' $file |sed -e 's/^\"\|\"$//g'|tr '[:space:]\.\,' '\n' | grep -e '^#'|sed -e 's/[^[:alnum:]\#\@\_].*//g'|tr '[:upper:]' '[:lower:]' |sort |uniq -c|sort -bnr|head

#Top 10 users by frequency of retweets
echo "Top 10 retweeted users by $username"
csvfix order -fn 'Text' $file |sed -e 's/RT @/RT@/g' -e 's/^\"\|\"$//g'|tr '[:space:]\.\,' '\n' | grep -e '^RT@'|sed -e 's/[^[:alnum:]\#\@\_].*//g' -e 's/^RT//g'|tr '[:upper:]' '[:lower:]' |sort |uniq -c|sort -bnr|head

#Top 10 users mentioned in tweets that are NOT retweets and who are NOT the user in question.
echo "Top 10 mentioned users (not including retweets) by $username"
csvfix order -fn 'Text' $file |sed -e 's/^\"\|\"$//g'|grep -v -e 'RT @\|RT: @'| tr '[:space:]\.\,' '\n' | grep -e '^@'|sed -e 's/[^[:alnum:]\#\@\_].*//g'|tr '[:upper:]' '[:lower:]' | sort |uniq -c|sort -bnr|head

#Top ten words, 5-letters or more, that are not usernames, nor hashtags, nor URLs.
echo "Top tweeted 10 words with 5+ letters by $username"
csvfix order -fn 'Text' $file |sed -e 's/RT @/@/g' -e 's/^\"\|\"$//g'|tr '[:space:]\.\,' '\n' |grep -v -e '^http://'|sed -e 's/[^[:alnum:]\#\@\_]/\n/g'|grep -E '^[[:alpha:]]{5}'|tr '[:upper:]' '[:lower:]' | sort |uniq -c|sort -bnr|head


