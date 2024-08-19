# condition controlled loop
condition = 0
while condition <= 12:
    print(2*condition)
    condition += 1

# count controlled loop 
for num in range(10,21):
    print(num)

# collection controlled loop
list_1 = [10,20,30,40,50,60]
for ele in list_1:
    print(ele, end=" ")

import keyword
list_1 = [10,20,30,40,50,60]
print(keyword.kwlist)

print(len(keyword.kwlist))

print(type(list_1))

# delete a python object
del(list_1)

list_val = []

statement = "How are you doing today?"
for letter in statement:
    list_val.append(letter)

print(list_val)

# conditional statements
bro_age = int(input("Enter brother's age: "))
sis_age = int(input("Enter sister's age: "))

if bro_age > sis_age:
    print("Brother is elder")
elif bro_age < sis_age:
    print("Sister is elder")
else:
    print("Both are twins")

# Create login access using loop and condition statements.

while True:
    choice = input("Choose an option: ")
    if choice == 'login':
        user = input("Enter username: ")
        password = input("Enter user's password: ")
        if user == 'admin' and password == 'password':
            print("Login successfull , welcome")
        else:
            print("Incorrect username or password")
    elif choice == 'quit':
        print("Exiting from program , Goodbye")
        break
    else:
        print("Invalid choice. Choose option as 'login' or 'quit'")


# Break and Continue
list_a= ['Mumbai',None,'Kolkata',None, None ,'Pune']

for ele in list_a:
    if ele == None:
        continue
    else:
        print(ele)
