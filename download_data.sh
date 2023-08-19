#!/usr/bin/env bash

BASE_URL="https://doaj.org/api"
OUTFILE=raw_data.jsonl

for year in $(seq 2023 -1 1970)
do
    echo "Doing year $year"
    QUERY=$(python3 <<EOF
keywords = ["animal ethics", "animal legislation", "animal welfare", "animal rights"]

def format_keyword(kw: str):
    kw = kw.replace(" ", "%20")
    return f'bibjson.keywords.exact:%22{kw}%22'

keyword_query = "%20OR%20".join(map(format_keyword, keywords))
print(f"%28{keyword_query}%29%20AND%20bibjson.year.exact:%22$year%22")
EOF
    )
    curl -s -X GET --header "Accept: application/json" \
        "$BASE_URL/search/articles/$QUERY?page=1&pageSize=5" \
        >> $OUTFILE
    echo >> $OUTFILE
    sleep .5
done

