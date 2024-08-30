// Traits
// A trait is special type of class which is used to define collection of methods  and fieldnames that can be reused
// across different classes

// Traits usage:  Comes under code reusability in scala, Instead of duplicating code in multiple classes
// you can define common functionality in a trait then you can mix it with any class

// scala does not support multiple inheritance (A class inherited from more than 1 class)
//  But traits helps you to achieve this . A class can extend one class and mix it in multiple traits

trait Drivable {
  def drive(): Unit
}
trait Flyable{
  def fly(): Unit = {
    println("Flying in the sky")
  }
}
class car(val make: String , val model: String) extends Drivable {
  override def drive(): Unit = {
    println(s"Driving $make $model")
  }
}
class Airplane(val make: String , val model: String) extends Flyable with Drivable {
  override def drive(): Unit = {
    println(s"Taxiing on the runaway")
  }

  override def fly(): Unit = {
    println(s"Airplane is flying at 30000 ft.")
  }
}


