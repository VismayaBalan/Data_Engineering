object DataStructures_2{
  def main(args:Array[String]): Unit = {
    // scala collection - map
    // Map: collection of key value , it can be mutable or immutable,
    // by default , it is immutable
    val fruitBasket = Map("Apricon" -> 20,"Blueberry" -> 250,"Cherry" -> 100,"Donuts" -> 24,"Eclairs" -> 100)
// mutable maps
    import scala.collection.mutable
    val mutableMap = mutable.Map("Apricon" -> 20,"Blueberry" -> 250,"Cherry" -> 100,"Donuts" -> 24,"Eclairs" -> 100)

    // Basic operations

    val value = fruitBasket("Donuts")
    println(fruitBasket.contains(("Donuts")))
    val mapSize = fruitBasket.size
    println(mapSize)

    val keys = mutableMap.keys
    val values = mutableMap.values

    // Adding and removing in map
    mutableMap += ("fig" -> 26)
    mutableMap -= ("Eclairs")
    // apply on immutable map
    val newFruitBasket = fruitBasket +  ("fig" -> 26)
    // update the value
    mutableMap("Fig") = 30

    // Scala Sets - A set is collection in scala which contains
    // no duplicate values. Sets can be mutable or immutable,
    // by default sets are immutable.

    val set1 = Set(1, 2, 3, 4, 5, 6, 7, 8)
    val set2 = Set("Apple", "Banana", "Cheery", "Grapes", "Tomato",
      "Oranges", "Watermelon", "Pineapple")

    // Basic Operations
    println(set1.contains(5))
    println(set1.size)
    println(set1 + 9)

    // Union of sets
    val set3 = Set("Grapes", "Tomato", "Guava", "Oranges", "Banana")
    val fruitBasket_ = set2 union set3
    println(fruitBasket)

    // Intersect : Common value between Two Sets.
    val interSet = set2 intersect set3

    // Difference
    val diffSet = set2 diff set3
    println(diffSet)

    val diffSet1 = set3 diff set2
    println(diffSet1)

    // subset check
    val isSubset = set2.subsetOf(set3)
    println(isSubset)

    // Transformation - map, filter, reduce
    println(set3.map(_.toLowerCase()).mkString(","))
    println(set1.map(_ * 2).mkString(","))
    println(set3.filter(_.startsWith("G")).mkString(","))

    // mutable Sets
    val set4 = mutable.Set(10, 20, 30, 40, 50, 60, 70)
    set4 += 10
    set4 ++= Set(80, 90)
    set4 --= Set(10, 20)

    // clear Sets
    set4.clear()

    // create a new collection
    val fruitList = List("apple", "apricot", "banana", "chocolate", "coconut")
    val mapFruits = fruitList.groupBy(_.head)
    val newmapFruits: mutable.Map[Char, List[String]] = mutable.Map(mapFruits.toSeq: _*)
    println(newmapFruits.mkString(","))
    newmapFruits ++= Map('d' -> List("Dragon Fruit"),'e'->List("Eclairs"))

    // Tuple Datatype
    // Tuple : collection of immutable datatype, fixed size, heterogenous
    val tuple1 = (1, "hello tuple", 3.14, "scala", 2635721L)
    val firstValue = tuple1._1
    val secondValue = tuple1._2


    // Pattern matching in Tuple
    val(var1,var2,var3) = (1, "hello tuple", 3.14)
    println(var1)
    println(var3)

    // returns no of elements present in tuple

    println(tuple1.productArity)

    // returns datatype of variable
    println(tuple1.getClass)

    // copy : allows you to copy tuple with some elements replaced

    val newTuple = tuple1.copy(_4 = "new value")
    println(newTuple)
    // Arrow function (=>) - used to denote a lambda expression or anonymous function
    // (parameter) => (expression)
    tuple1.productIterator.foreach{
      (element => println(s"Element: $element"))
    }

  }
}
