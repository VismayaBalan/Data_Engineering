# User Defined Functions
def greetings():
    return "Hello, how are you doing today ? "



# Lambda functions
multiplier = lambda x : x * 2
#Declare a function with an argument 
print(multiplier(20))

# Functional programming or methods

# map()
list_numbers = [10,20,30,41,50]
new_list = list(map(lambda x: x * x , list_numbers))
print(new_list)

# filter()

filtered_list = list(filter(lambda x: x % 2 == 0,list_numbers))
print(filtered_list)

# reduce()
from functools import reduce

reduced_list = reduce(lambda x,y:x + y, list_numbers )
print(reduced_list)

# Create a function and apply it on reduce() method  to return aggregate sales data

sales = [{'product':'Laptop','amount':50000},
         {'product':'Iphone','amount':150000},
         {'product':'SmartTv','amount':75000},
         {'product':'Gaming Console','amount':35000},
         {'product':'Mouse','amount':500},
         {'product':'Iphone','amount':75000},
         {'product':'Laptop','amount':70000},
         ]
# Accumulate total sales for each product

def accumulate(accumulator,transaction):
    product = transaction['product']
    amount = transaction['amount']
    accumulator[product] += amount
    return accumulator


from collections import defaultdict

# reduce(function, iterable, initializer)  Initializer - A stsrting value used to initialize

total_sales = reduce(accumulate,sales,defaultdict(int))
print(total_sales)
for product, amount in total_sales.items():
    print(f'{product} - {amount}')

# Find top selling product and top selling revenue

top_product = max(total_sales,key=total_sales.get)
max_amount = total_sales[top_product]



print(f"Top selling product is {top_product} and amount is {max_amount}")


# *args & **kwargs

def Func1(*args):
    print(sum(args))

list_1 = [1,2,34,5]

Func1(*list_1)

dict1 = {"First Name": "John" , "Middle Name": "S" , "Last Name": "Jacob"}

def Func2(**kwargs):
    for key, value in kwargs.items():
        print(f"My {key} is {value}")


Func2(**dict1)



    
