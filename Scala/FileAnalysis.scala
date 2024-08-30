import scala.io.Source

object FileAnalysis{
  def main(args:Array[String]): Unit = {
    // Read from file
    val source = Source.fromFile("C:/Users/Administrator/Downloads/sample.txt")

    // Read all values and create list of lines
    val lines = source.getLines().toList
    // close the file object
    source.close()

    // Process the file data
    val words = lines.flatMap(_.split("\\s+")).map(_.toLowerCase)
    println(words)
    // group words by identity
    // map values by its size
    // get wordcount and sort by words in descending order using negated values
    // 2 means values it u need words then use 1


    //1. Print top 10 most frequent words
    val wordcount = words.groupBy(identity).mapValues(_.size).toSeq.sortBy((-_._2))
    // - means descending

    wordcount.take(10).foreach{
      case (word, count) => println(s"$word: $count")
    }
    // Find the count of words
    println("Count of words " +words.length)

    // Find the word with max and min length


    val sortedList = words.sortBy(_.length)

    println(sortedList.head)
    println(sortedList.last)



















  }}
