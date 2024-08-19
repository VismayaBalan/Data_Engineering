str1 = ' This is python string'

#Reverse the string using index
print(str1[::-1])
str.lower(str1)
print('The start index possition of Python in string: {}'.format(str1.find('python')))


# Join collection of word strings to join and create sentence
list_1 = ["hello", "how", "are", "you", "doing", "today"]
sentence = " ".join(list_1)
print(sentence)


take_input = int(input("Enter a number: "))
print(f'print a number {take_input}')

# Remove white spaces from string usage - users input like email id , password
stripped_text = sentence.lstrip()
print(stripped_text)

#partition the input sentence seperated by delimiter 
print(sentence.rpartition(" "))


# List and its methods
list_2 = []
list_3 = list()
list_2 = ['Hello', 'Python', 'we', 'are', 'learning', 'lists']
list_2.append("and")


#shallow copy - copy only the values
list_3 = list_2.copy()
#deep copy - copy by refernce 
list_4 = list_2

list_2.append("data structures")
print(list_3)
print(list_4)


list_2.extend(["tuples", "sets", "dictionary", "all", "are", "lists."])
print(list_2)

list_2.pop()
#Removing element from list using index
list_2.pop(-2)
print(list_2)

# Tuples iterates faster compared to lists. 
# Lists manages two memeory where tuples manages only one.

# sets - unordered collection of data. As it is unordered hence, no indexes 

set_1 = set()
set_1 = {'A','B', 'C', 'D','E','E','H','A'}
set_2 = {'B','D','G','F','G','H','I','J'}
set_2 = {'H','I','J','K','L','M','N','O'}

print(set_1.difference(set_2))
print(set_2.difference(set_1))

print(set_1)
#remove random value from set
set_1.pop()
print(set_1)

# concatenation of two sets without including duplicate values
set_1.union(set_2)
# updates the set_1 by dummy input set
set_1.update({'O','P','Q'})
# union of two sets containing elements present in either of the sets but not present in both.
print(set_1.symmetric_difference(set_2))

# common between both sets
set_1.intersection(set_2)

# Dictionary
dict_1 = {} # declare an empty dictionary
#Method 1
dict_1 = {'A':'Apple', 'B':'Blueberry', 'C':'Coconut', 'D':'Donuts'}
city_names = ['Mumbai','Kolkata', 'Pune']
employees = [20,30,40]
#Method 2
dict_2 = dict.fromkeys(city_names)
dict_2 = dict(zip(city_names,employees))
print(dict_2)
#Method 3
dict_3 = dict([('Mumbai',20),('Kolkata',30),('Pune',40)])
print(dict_3)

for key,value in dict_3.items():
    print(key,value)

for i, ele in enumerate(list_1):
    print(i,ele)

for index, key in enumerate(dict_3):
    print(f'Index {index} : key = {key}, value = {dict_3[key]}')






