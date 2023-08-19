#!/usr/bin/env bash

echo -e total > total.csv
cat raw_data.jsonl | jq '.total' >> total.csv
