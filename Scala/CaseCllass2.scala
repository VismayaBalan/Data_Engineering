object CaseCllass2{
  def main(args:Array[String]): Unit = {

    // Define a case class
    case class Employee(name: String, age: Int)

    // Create an interface (object) of case class
    val obj = Employee("Vismaya", 20)

    // Access fields
    println(obj.age)
    println(obj.name)

    // pattern matching

    obj match {
      case Employee(name, age) => println(s"Name: $name, Age: $age")
    }

    // create a copy with modified fields to update
    val olderObj = obj.copy(name = "Anu")
    println(olderObj)

  }}
