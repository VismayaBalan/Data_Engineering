// Case class are special class in scala that are immutable and compared by value
// they are majorly used for pattern matching
// Define case class
// Case classes in scala are spl kind of class that is used for 
// modelling immutable data structures (impt)
// case classes will automatically provide useful methods 
// toString, equals,hashCode,copy, apply built in support for pattern matching
case class Person(name:String, age:Int)

// Main object
object Main extends App{
  // create object of case class
  val person = Person("Tom", 20)

  // define a function to describe a person
  // case class is used for pattern matching
  def describePerson(person: Any): String = person match {
    case Person(name, age) => s"Person name: $name, age: $age"
  }

  // test functionality
  println(describePerson(person))

}
