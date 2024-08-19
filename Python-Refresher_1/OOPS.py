var_1 = 10
#var_1 is an object of class integer
print(type(var_1))

class Person:
    def __init__(self,*args):
        if len(args) >= 4:
            self.name = args[0]
            self.age = args[1]
            self.dob = args[2]
            self.email = args[3]
        else:
            raise ValueError("Not enough arguments passed. Expected exactly 4")

    def display(self):
        print("Person Details")
        print(f"Name: {self.name}")
        print(f"Age: {self.age}")
        print(f"Dob: {self.dob}")
        print(f"email: {self.email}")




person1 = Person("Vismaya", 22, "28/01/2002", "vismaya@gmail.com")
person1.display()

# Inheritance

# Single level inheritance

class Vehicle:
    def __init__(self, brand, model, mileage):
        self.brand = brand
        self.model = model
        self.mileage = mileage

class Car(Vehicle):
    

    def __init__(self,brand, model, mileage, speed,color):
        super().__init__(brand, model, mileage)
        self.speed = speed 
        self.color = color

    def Display(self):
        print(f"Brand : {self.brand}")
        print(f"Model : {self.model}")
        print(f"Mileage : {self.mileage}")
        print(f"Speed : {self.speed}")
        print(f"Color: {self.color}")

car1 = Car("brand1","model1",50,120,"black")
car1.Display()


# Multi level Inheritance

# Access Permissions

class Enitiy:
    def __init__(self,name):
        self.name = name

class User(Enitiy):
    def __init__(self, name, email):
        super().__init__(name)
        self.email = email

class Admin(User):
    def __init__(self, name, email, permissions):
        super().__init__(name, email)
        self.permissions = permissions
    def Display(self):
        return f"{self.name} has following permissions {','.join(self.permissions)}"
    
obj1 = Admin("admin","admin@gmail.com",['read','write','execute'])
print(obj1.Display())

# Hierarchical Inheritance

class Phone:
    def __init__(self,brand,model,color):
        self.brand =  brand
        self.model = model
        self.color = color

class Android(Phone):
    def __init__(self,brand,model,color,os,version,processing):
        super.__init__(brand,model,color)
        self.os = os
        self.version = version
        self.processing = processing
    def androidDisplay(self):
        print("Android phone Description")
        print(f"Brand: {self.brand}")
        print(f"Model: {self.model}")
        print(f"Color: {self.color}")
        print(f"Os: {self.os}")
        print(f"Version: {self.version}")
        print(f"Processing Unit: {self.processing}")

class IPhone(Phone):
    def __init__(self,brand,model,color,os,version,processing):
        super.__init__(brand,model,color)
        self.os = os
        self.version = version
        self.processing = processing
    def IphoneDisplay(self):
        print("Iphone phone Description")
        print(f"Brand: {self.brand}")
        print(f"Model: {self.model}")
        print(f"Color: {self.color}")
        print(f"Os: {self.os}")
        print(f"Version: {self.version}")
        print(f"Processing Unit: {self.processing}")

# Multiple Inheritance

class Developer:
    def __init__(self,name,account):
        self.name = name
        self.account = account


class Manager:
    def __init__(self,project, projectId):
        self.project = project 
        self.projectId = projectId


class Employee(Developer,Manager):
    def __init__(self, name, account,project, projectId):
        Developer.__init__(self,name, account)
        Manager.__init__(self,project,projectId)

    def Display(self):
        print("Employee Details")
        print(f"Name: {self.name}")
        print(f"Account: {self.account}")
        print(f"Project: {self.project}")
        print(f"ProjectId: {self.projectId}")


obj1 = Employee("John","T Mobile","Gen AI",2239)
obj1.Display()


# Abstraction 
# abc - abstract class


from abc import ABC, abstractmethod

class Bill(ABC):
    def printSlip(self,amount):
        print("Purchase Amount: ", amount)

    @abstractmethod
    def bill(self,amount):
        pass

class DebitCardPayment(Bill):
    # Method overriding
    def bill(self,amount):
        print("Debit card payment of - ", amount )

absobj = DebitCardPayment()
absobj.printSlip(10000)
absobj.bill(10000)


