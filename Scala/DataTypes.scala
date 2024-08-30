object DataTypes{
  def main(args: Array[String]): Unit = {
    // Primitive Data Types

    // Numeric Types
    val intValue: Int = 25
    var doubleValue: Double = 23.00000000000
    var longIntVal: Long = 483750297502935L
    var floatValue: Float = 45.67F

    // Character and String Type
    var charValue: Char = 'A'
    var stringValue: String = "Hello Scala"

    // Byte Type
    var byteValue: Byte = 127

    // Boolean Type
    var booleanValue: Boolean = true
    
    // val - Immutable 
    // Var - Mutable

    println("Integer Value: " + intValue)
    println("Boolean Value: " + booleanValue)
    println("Character Value: " + charValue)
    println("String Value: " + stringValue)
    
    // Re initialize value
    charValue = 'B'
    println("Char new value: " + charValue)
    // intValue = 5
    println("Int new value: " + intValue)


  }
}
