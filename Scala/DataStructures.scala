object DataStructures{
  def main(args: Array[String]): Unit = {
    // collection of datatypes
    // immutable,homogenous, variable length
    val valList:List[String] = List("Apricon","Blueberry","Cherry","Donuts","Eclairs")
    println(valList)
    // collection.foreach(println)
    valList.foreach(println)

    // empty list declaration
    val emptyList: List[Nothing] = List()

    val firstValue = valList.head
    val restValues = valList.tail
    val lastValue = valList.last
    val secondValue = valList(1)
    val length = valList.length

    println("display first value: " + firstValue)
    println("display rest value: " + restValues)
    println("display last value: " + lastValue)
    println("display second value: " + secondValue)
    println("display length: " + length)

    // valList = valList :+ "fig"  appending to an existing list is not possible because of its immutability
    val newList = valList :+ "Fig"
    println("Is valList empty ? " +valList.isEmpty)

    val newValList = List("Fig","Grapes","Hazelnut")
    // concatenation of list
    val fruitBasket = valList ++ newValList

    // Transformation of list
    val list_1 = List(5,4,4,7,3,2,9,7,5,8,2,1)
    println(list_1.map(_*3))
    val evenNum = list_1.filter(_%2 == 0)
    println("Even Numbers: " +evenNum)

    val nestedList = List(List("Delhi","Kochi","Bengaluru","Kolkata"),
                          List("Pune","Mumbai","Varkala"),
                          List("Trivandrum","Kolkata","Visakhapatnam","Palakkad"))
    println(nestedList)
    // identity is predefined function A=>A
    println(nestedList.flatMap(identity))

    println(list_1.filter(_%2==0).reduce(_+_))

    println(nestedList.flatten)

    // returns list of characters length from input list
    println(fruitBasket.map(_.length))
    // Returns boolean value if string starts with string "A"
    println(fruitBasket.map(_.startsWith("A")))
    // sort the list by word length
    val sortedList = fruitBasket.sortWith(_.length < _.length)
    println(sortedList)
    val sortedCity = nestedList.flatten.sortBy(_.length)
    println(sortedCity)

    // list of city that begins with letter K
    val filtered_ = sortedCity.filter(_.startsWith("K"))
    println(filtered_)
    // Alternative
    val filtered__ = sortedCity.filter(_.head == 'K')
    println(filtered__)

    // Subset and slicing
    val city = nestedList.flatten
    println(city.takeRight(5))
    println(city.take(5))
    println(city.drop(1))
    println(city.dropRight(2))
    // slicing the lists using start index & last Index position
    println(city.slice(1,6))
    // slicing using random index position (0,2,4,5,7,9)
    val indices = List(0,2,4,5,7,9)
    // lift() : method that retrieves an element at specified index
    println(indices.flatMap(index => city.lift(index)))
    println(city)


    val population = List(33807403, 3507053, 14008262, 15570786, 7345848, 21673149, 50000, 2984154, 15570786, 2385110, 130000)
    val pairedList = city.zip(population)
    println(pairedList)

    // Arrays: : mutable collection - indexed with sequence of elements
    // Array provides fast actions and modification of elements, making

    val emptyArray = Array[Int]()
    val Array1 = Array(1,2,3,4,5,6)
    // access indvidual value using index
    val firstElement = Array1(0)
    val secondElement = Array(1)

    // update the existing value
    Array1(0) = 10
    Array1.foreach(println)

    // getting length of an array
    println(Array1.length)

    // Adding or removing values from an array
    // Array1 += 7
    // Array1 -= 3
    import scala.collection.mutable.ArrayBuffer

    val arrayBuffer = ArrayBuffer(1,2,3,4,5,6,7,8,9,10)
    arrayBuffer += 13
    arrayBuffer -= 1
    val newArray = arrayBuffer.toArray
    newArray.foreach(println)
    val Array2 = ArrayBuffer(Array1:_*)
    Array2.foreach(println)
    // apply mkstring to collection of array, lists
    println(Array2.mkString(","))

    // Transformation of array

    // map
    println(arrayBuffer.map(_*2))

    // filter
    println(arrayBuffer.filter(_ % 2 == 0))

    // flatten
    val arrayBuffer2 = ArrayBuffer(ArrayBuffer(1,2,3,4,5),ArrayBuffer(6,7,8,9,10))
    println(arrayBuffer2.flatten)

    // Subset and slicing

    println(newArray.takeRight(5).mkString(","))
    println(newArray.take(5).mkString(","))
    println(newArray.drop(1).mkString(","))
    println(newArray.dropRight(2).mkString(","))
    // slicing the lists using start index & last Index position
    println(newArray.slice(1, 6).mkString(","))

    // reverse an array
    println(newArray.reverse.mkString(","))

  // sorting an array
    val unsortedArray = Array(29,27,456,345,87,35)
    println(unsortedArray.sorted.mkString(","))
  }
}
