// Code Challenge: Write a function that takes in an array of numbers, and returns the lowest and highest numbers as a tuple

import Foundation

let array1 = [3,6,3,93,43,12,4,23,7,76,2,-1,22]
let array2 = [111]
let array3 = [Int]()
let array4 = [17,17,17,17,17,17,17]
let array5 = [1234,1]

// document this function as requiring a non-empty array as input or change the output
// to be an optional tuple (which is less desired to me). should we fatal error if
// an empty array is passed as input? perhaps
func lowestAndHighest(array: [Int]) -> (lowest: Int, highest: Int) {
  //if array.isEmpty { fatalError("lowestAndHighest() requires non-empty array as input parameter") }
  let low = array.reduce(Int.max) { min($0, $1) }
  let high = array.reduce(Int.min) { max($0, $1) }
  return (lowest: low, highest: high)
}

lowestAndHighest(array1)
lowestAndHighest(array2)
lowestAndHighest(array3)
lowestAndHighest(array4)
lowestAndHighest(array5)
