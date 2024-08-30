object Functions{
  def main(args:Array[String]): Unit = {
    import scala.io.StdIn.readLine
    // Function is block of code which does certain task and can be called repeatedly
    // 1 Create a function which takes username as input and returns the same
    // Declare a function: UDF (User Defined function)
 /*   import scala.io.StdIn.readLine

    def greet(name: String): Unit ={
      println(s"Hello $name, Welcome to UST! ")
    }

    println("please enter the username: ")
    val username = readLine()

    // call the function using users input
    greet(username)

    // 2. Function to do addition which takes more than 1 parameter
    import scala.io.StdIn.readInt
    def add(a: Int, b:Int ): Int = {
      a+b
    }

    println("Enter number1")
    var a = readInt()
    println("Enter number2")
    var b = readInt()

    println(add(a,b))


    // Alternative

    import scala.io.StdIn.readLine
    def addNew(a: Int, b: Int): Int = {
      a + b
    }


    var x = readLine("Enter number1: ").toInt
    var y = readLine("Enter number2: ").toInt

    println(addNew(x,y))

    //3. Create a scala function Calculator:

    def Calculator(a:Int, b:Int, op:String): Any = {
      if (op == "+"){
        return a + b
      }else if(op == "-"){
        return a-b
      }else if(op == "*"){
        return a*b
      }else if(op == "/" && b != 0){
        return a/b
      }
    }

    x = readLine("Enter number1: ").toInt
    y = readLine("Enter number2: ").toInt
    var op = readLine("Enter operator: ")
    println(Calculator(x,y,op))
    */
    //4. declare a function with default value
    def Divide(a:Int,b:Int=2): Any = {
      return a/b
    }

    var p = readLine("Enter num1: ").toInt
    var q = readLine("Enter num2: ").toInt
    println(Divide(p,q))
    println(Divide(p))

    // 5. Lambda function or anonymous function
    val add = (a:Int,b:Int) => a+b
    println(add(p,q))

    // 6. Higher Order Function: function passed as parameter
    // function which takes another function as parameter
    def applyFunction(f:(Int,Int) => Int, value1: Int, value2: Int): Int = {
      f(value1,value2)
    }
    applyFunction(add,p, q)



    // create a function to check if there is a duplicate entry and remove the duplicate entry

    var list1 = List(1, 2, 3, 5, 3)

    def duplicate(List1:List[Int]): List[Int] = {
      return List1.distinct
    }

    println(duplicate(list1))

    // create a function if input is palindrome or not Palindrome

    def palindrome(word:String): String ={
      if (word == word.reverse){
        return "Palindrome"
      }else{
        return "Not Palindrome"
      }
    }

    var word = readLine("Enter the word:")
    println(palindrome(word))

    //9. create a scala function which returns factorial of a number

    def factorial(n:Int): Int = {
      if (n==0) 1
      else n * factorial(n-1)
    }
    // Example uses
    val number  = readLine("Enter the number to find factorial: ").toInt
    
    println(factorial(number))















  }}


