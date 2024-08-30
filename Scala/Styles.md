Styles: It refer to different ways of writing scala program

1. Functional Style
2. Object Oriented Style
3. Pattern Matching styles
4. For comprehensions
    ```scala
    val num = List(1,2,3,4,5,6,7,8)
    val result = for {
      n <- num
      squared  = n* n
    } yield squared
    println(result)
    ```
5. If comprehension
6. Type class
7. Traits and Mixins
8. Imperative Styles