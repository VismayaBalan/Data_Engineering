# Use datetime Package

import datetime

print("Display todays date: ", datetime.date.today())
print(datetime.datetime.now())

today = datetime.date.today()
print(f"Day: {today.day} Month: {today.month} Year: {today.year}")



# Usage of datetime with an example

class Person:
    def __init__(self,name,surname,birthdate,contact,email):
        self.name = name 
        self.surname = surname
        self.birthdate = birthdate
        self.contact = contact
        self.email = email

    def age(self):
        today = datetime.date.today()
        age = today.year - self.birthdate.year 
        if today < datetime.date(today.year, self.birthdate.month, self.birthdate.day):
            age -= 1
        if age <0:
            print("Person is not born")
        return age

person = Person("Vismaya","abc",datetime.date(2002,1,28),"9526820112","vismaya@gmail.com")
print(person.age())


# File Handling

# open the file in default mode - read mode.

fileobj = open('newfile.txt')
print(fileobj.read())

fileobj = open('newfile.txt','r')
# open file with write mode
fileobj = open('newtextfile.txt','w')
fileobj.write("This is new content added to the new file ")
fileobj.close()

# 'r+ - open file in read and write mode
fileobj1 = open('newtextfile.txt','r+')
print(fileobj1.read())
print("Read Again")

# Seek (0)  - Position the file cursor at first position

fileobj1.seek(0)
print(fileobj1.read())

fileobj1.write("\nThis is another content appended in EOF")
fileobj1.seek(0)
print(fileobj1.read())


# 'w+ - open file in write and the read mode
fileobj2 = open('newfile.txt','w+')
print(fileobj2.read())
fileobj2.write("\n write the content in the newfile.")
fileobj2.seek(0)
print(fileobj2.read())
fileobj2.close()

# Usage of with in file

with open('newtextfile.txt','r+') as fileobj:
    data = fileobj.readlines()
    for line in data:
        words = line.split()
        print(words)


# List Comprehension

list_1 = [x**2 for x in range(1,11) if x % 2 == 0]
print(list_1)

Marks = [25,35,95,75,83]
Grade = lambda x : 'A' if x >= 90 else 'B' if x >= 80 else 'C' if x >=70 else 'D'

Grades = [Grade(i) for i in Marks]
print(Grades)

