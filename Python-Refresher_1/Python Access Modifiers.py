# public, protected and private access modifiers

# Protected access modifiers
class Employee:
    _name = None
    _department = None

    # Declare Constructor
    def __init__(self,name,department):
        self._name = name
        self._department = department

    def _display(self):
        print("Employee Name:", self._name)
        print("Employee Department:", self._department)


class EmployeeDetails(Employee):
    def __init__(self, name, department):
        Employee.__init__(self,name, department)
    def displayDetails(self):
        self._display()

obj1 = EmployeeDetails("Vismaya","IT")
obj1.displayDetails()

# Private access Modifiers

class PEmployee:
    __name = None
    __department = None

    # Declare Constructor
    def __init__(self,name,department):
        self.__name = name
        self.__department = department

    def __display(self):
        print("Employee Name:", self._name)
        print("Employee Department:", self._department)


class PEmployeeDetails(PEmployee):
    def __init__(self, name, department):
        Employee.__init__(self,name, department)
    def displayDetails(self):
        self.__display()

obj2 = PEmployeeDetails("ROhit","Testing")
obj2.displayDetails()


