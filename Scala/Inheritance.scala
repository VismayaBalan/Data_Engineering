// Parent class
class Animal (val name: String){
  def makeSound(): Unit = {
    println(s"$name makes sound")
  }
}

// sub class
class Dog(name: String) extends Animal(name){
  override def makeSound(): Unit = {
    println(s"$name make sound: Woof!")
  }
}
object InheritanceExample extends App{
  val animal = new Animal("Generic name")
  animal.makeSound()

  val dog = new Dog("jacky")
  dog.makeSound()
}