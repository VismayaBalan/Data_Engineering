
    class Employee(private var empname: String, private var salary:Int){
      // Setter - set method
      // Data
      def setName(newEmpName: String): Unit = {
        if(newEmpName.nonEmpty) empname = newEmpName
      }
      // getter
      def getName: String = empname

      //set Method
      def setSalary(newSal: Int): Unit = {
        if (newSal > 0) salary =newSal
      }
      //getter
      def getsalary: Int = salary

    }

    object Encapsulation extends App {
      val emp1 = new Employee("Tom",64758)
      emp1.setName("Jerry")
      emp1.setSalary(100000)
      println(emp1.getName)
      println(emp1.getsalary)

    }

