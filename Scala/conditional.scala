object conditional{
  def main(args:Array[String]): Unit = {
    // If condition
    val x = 10
    if (x > 5){
      println(s"$x is greater than 5")
    }else{
      println(s"$x is lesser than 5")
    }
    // If else as an expression
    val y = 1
    val result = if (y%2 == 0) "Even" else "Odd"
    println(result)

    // Ask user to input the data
    import scala.io.StdIn._
    println("Please enter a value: ")
    //Read user input and convert to integer
    val value = readInt()
    val results = if (value % 2 != 0) "Odd" else "Even"

    // print result
    println(results)
  // program which asks user to input a number and print grade

    println("Enter a mark: ")
    val mark = readInt()
    
    if (mark > 90){
      println("A")
    } else if (mark > 80){
      println("B")
    }  else if (mark > 70){
      println("C")
    } else if (mark>60){
      println("D")
    } else if (mark > 50) {
      println("E")
    } else "F"

    val grade = if (mark > 90) "A" else if (mark > 80) "B" else if (mark > 70) "C" else if (mark>60) "D" else if (mark > 50) "E" else "F"
    println(s"The grade is $grade")

  }
  }
