// In sacala programming switch is reffered as match

object MatchCase{
  def main(args:Array[String]): Unit = {
    def dayOfWeek(day: Int): String = day match {
      case 1 => "Monday"
      case 2 => "Tuesday"
      case 3 => "Wednesday"
      case 4 => "Thursday"
      case 5 => "Friday"
      case 6 => "Saturday"
      case 7 => "Sunday"
      case _ => "Invalid number"


    }
    println((dayOfWeek(1)))
    println((dayOfWeek(5)))
    println((dayOfWeek(9)))

    def StringMatch(Input: String): String = Input match {
      case "Vivek" => "Hello Vivek"
      case "Elias" => "Good Afternoon Elias"
      case "Vismaya" => "Hello not Anu"
      case _ => "Hello strangers"



    }

    println((StringMatch("Vivek")))
    println((StringMatch("Vismaya")))
    println((StringMatch("Sarath")))


    def CalculatorMatch(Input1: Int, Input2: Int , op: String): Any = op match {
      case "+" => Input1 + Input2
      case "-" => Input1 - Input2
      case "*" => Input1 * Input2
      case "%" => Input1 % Input2
      case "**" => Math.pow(Input1,Input2)
      case "/" => if Input2 > 0 then Input1 / Input2 else "Not divisible"
      case _ => "Invalid operator"



    }

    println((CalculatorMatch(5,6,"*")))
    println((CalculatorMatch(5,6,"/")))
    println((CalculatorMatch(5,0,"/")))
    println((CalculatorMatch(5,6,"%")))
    println((CalculatorMatch(5,2,"**")))


  }}
