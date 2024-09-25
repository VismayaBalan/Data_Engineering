#!/usr/bin/python3
"""mapper1.py"""
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
                zone = columns[4].strip()
                reg_zone = columns[5].strip()
                prod_wg = columns[-1].strip()
            except:
                continue
            print(f"{zone},{reg_zone},{prod_wg}")
