// Parent class
class Ecommerce (val name: String, val quantity: Float, val price: Float){
  def displayDetails(): Unit = {
    println(s"name: $name quantity: $quantity price:$price")
  }
}

// Inheritance - Electronics
// sub class
class Electronics(name: String, quantity: Float, price: Float) extends Ecommerce(name, quantity, price){
  override def displayDetails(): Unit = {
    val total = quantity * price
    println(s"name: $name quantity: $quantity price:$price total:$total")
  }
}

// Inheritance - Books
class Books(name: String, quantity: Float, price: Float, genre:String) extends Ecommerce(name, quantity, price){
  override def displayDetails(): Unit = {
    val total = quantity * price
    println(s"name: $name quantity: $quantity price:$price total:$total genre:$genre")
  }
}

// Inheritance - Footwear
class Footwear(name: String, quantity: Float, price: Float) extends Ecommerce(name, quantity, price){
  override def displayDetails(): Unit = {
    val total = quantity * price
    println(s"name: $name quantity: $quantity price:$price total:$total")
  }
}

object InheritanceExample2 extends App{
  val ecommerce = new Ecommerce("Product1",1,100)
  ecommerce.displayDetails()

  val electronics = new Electronics("Laptop",3,500000)
  electronics.displayDetails()

  val books = new Books("Alchemist", 5, 750,"fiction")
  books.displayDetails()

  val footwear = new Footwear("sandals", 1, 800)
  footwear.displayDetails()
}
