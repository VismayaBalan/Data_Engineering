

object Loops{
  def main(args:Array[String]): Unit = {
    // A simple while loop sysntax that print numbers from 1 to  9
    var variable = 1
    while (variable < 10) {
      println(variable)
      variable += 1
    }

    // For loop
    val fruits = List("apple", "banana", "cherry", "DragonFruit", "mango", "oranges")
    for (fruit <- fruits) {
      println(fruit)
    }
    // for loop with step size 1 default
    for (i <- 1 to 10) {
      println(i)
    }
    // for loop with step size 2
    for (i <- 1 to 10 by 2) {
      println(i)
    }

    val food_list = List("Idli", "vada", "dosa", "biriyani", "chocolate", "maggi")
    for (food <- food_list) {
      println(food)
    }
    // Filtering records in for loop using if condition

    //1. write a scala program which creates a collection of even array
    import scala.collection.mutable.ArrayBuffer

    val evenArray = ArrayBuffer[Int]()
    for (n <- 1 to 20 if n % 2 == 0) {
      evenArray += n
    }
    println(evenArray.mkString(","))

    // 2. write a scala program to show collection of prime number between 1 to 100
    import scala.collection.mutable.ArrayBuffer


    val primeArray = ArrayBuffer[Int]()

    var flag = 1
    for (m <- 2 to 100) {
      for (j <- 2 until math.sqrt(m).toInt if m % j == 0) {
        flag = 0
      }
      if (flag == 1) {
        primeArray += m
      }
      flag = 1
    }
    println(primeArray.mkString(","))

    // 3. fibinocci series

    import scala.collection.mutable.ArrayBuffer
    val FibiArray = ArrayBuffer[Int](0, 1)

    import scala.io.StdIn._
    println("Please enter a value: ")
    //Read user input and convert to integer
    val num = readInt()
    var n = 1
    while (n < num) {
      FibiArray += FibiArray(n) + FibiArray(n - 1)
      n += 1
    }
    println(FibiArray.mkString(","))

    // 4. print the first prime no greater than given number

    println("Please enter a value: ")
    // Read user input and convert to integer
    var num2 = readInt()
    num2 += 1

    var foundPrime = false

    while (!foundPrime) {
      var isPrime = true
      for (k <- 2 to num2 / 2) {
        if (num2 % k == 0) {
          isPrime = false
        }
      }
      if (isPrime) {
        println(num2)
        foundPrime = true
      }
      num2 += 1
    }










  }
  }






