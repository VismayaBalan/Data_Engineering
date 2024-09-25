#!/usr/bin/python3
"""mapper3.py"""
import sys
# input comes from standard input
for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()
    # If the line is not empty
    if line:
        columns = line.split(',')
        if columns:
            try:
                issue = columns[7].strip()
                prod_wg = columns[-1].strip()
            except:
                continue
            print(f"{issue},{prod_wg}")
