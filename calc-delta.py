#!/usr/bin/python

import csv
import datetime
import sys

def to_datetime(timestamp):
    return datetime.datetime.strptime(timestamp, '%a %b %d %I:%M:%S %p %Z %Y')

if __name__ == "__main__":
    timestamps = csv.reader(sys.stdin)
    for row in timestamps:
        start = to_datetime(row[0])
        end = to_datetime(row[1])
        print(f"{(end - start).seconds}")
    
        
