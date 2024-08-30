object NestedCaseClass{
  def main(args:Array[String]): Unit = {
    // define a case class for a Employee
    case class Employee(name: String, id: Int)

    // define a case class for a Department, which contains a list of employees
    case class Department(deptname: String, employees: List[Employee])

    // create an instance of employee
    val emp1 = Employee("Reshma",12345)
    val emp2 = Employee("Maria",35782)
    val emp3 = Employee("Vismaya",34742)

    // create an instance of department
    val dept1 = Department("HR",List(emp1,emp2))
    val dept2 = Department("IT",List(emp3))

    // Pattern matching with another case class
    dept1 match {
      case Department(deptname,employees) =>
        println(s"Department: $deptname ")
        employees.foreach{
          case Employee(name,id) =>
            println(s"Employee: $name, Id: $id")
        }
    }

    dept2 match {
      case Department(deptname, employees) =>
        println(s"Department: $deptname ")
        employees.foreach {
          case Employee(name, id) =>
            println(s"Employee: $name, Id: $id")
        }
    }




  }
  }
