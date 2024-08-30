
    // Define a class
    class Car(val make: String, val model:String, var year:Int){
      def displayInfo(): Unit = {
        println(s"Car info: $year $make $model")
      }

    }

    // create an object of class car
    // singleton object extends App (trait) which does not need a main function anymore
    object SimpleClass extends App{
      val car = new Car("Hyundai","Creta",2023)
      car.displayInfo()

      car.year = 2024
      car.displayInfo()
    }

