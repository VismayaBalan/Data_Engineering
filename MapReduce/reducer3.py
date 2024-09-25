#!/usr/bin/python3
"""reducer3.py"""
import sys

current_issue = None
current_wg_sum = 0
current_wg_min = float('inf')
current_wg_max = float('-inf')
product_count = 0

records = []

# Input comes from STDIN
for line in sys.stdin:
    line = line.strip()
    # Parse the input we got from mapper.py
    # Fields are separated by ','
    issue, prod_wg = line.split(",")
    # This IF-switch only works because Hadoop sorts map output
    # by key (here key is issue) before it is passed to the reducer
    try:
        prod_wg = int(prod_wg)
    except ValueError:
        continue

    if current_issue == issue:
        current_wg_sum += prod_wg
        current_wg_min = min(current_wg_min, prod_wg)
        current_wg_max = max(current_wg_max, prod_wg)
        product_count += 1
    else:
        if current_issue:
            avg_wg = current_wg_sum / product_count
            records.append((
                current_issue, 
                current_wg_sum, 
                avg_wg, 
                current_wg_min, 
                current_wg_max, 
                product_count
            ))
        current_issue = issue
        current_wg_sum = prod_wg
        current_wg_min = prod_wg
        current_wg_max = prod_wg
        product_count = 1

# Output the last record if needed
if current_issue:
    avg_wg = current_wg_sum / product_count
    records.append((
        current_issue, 
        current_wg_sum, 
        avg_wg, 
        current_wg_min, 
        current_wg_max, 
        product_count
    ))

# Sort the records by average weight (or any other metric you want)
records.sort(key=lambda x: x[1], reverse=True)

# Print header labels
print('{:<15} {:<15} {:<15} {:<15} {:<10} {:<10}'.format(
    'Issue', 'Total Weight', 'Average Weight', 'Min Weight', 'Max Weight', 'Count'
))

# Print the results
for record in records:
    print('{:<15} {:<15} {:<15.2f} {:<15} {:<10} {:<10}'.format(
        record[0], 
        record[1], 
        record[2], 
        record[3], 
        record[4], 
        record[5]
    ))

