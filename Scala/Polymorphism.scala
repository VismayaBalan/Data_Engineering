class Shape{
  def area(): Double = 0.0
}
// Derived class
class Rectangle(val height: Double,val width: Double) extends Shape{

  override  def area(): Double = height * width
}

class Triangle(val height: Double,val base: Double) extends Shape{

  override  def area(): Double = 0.5 * base * height
}

object Polymorphism extends  App{
  val shapes: List[Shape] = List(new Rectangle(10, 11), new Triangle(12, 3))
  shapes.foreach(shape => println(shape.area()))
}