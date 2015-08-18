// Code Challenge: Given an array of ints of odd length, return a new array length 3 containing the elements from the middle of the array. The array length will be at least 3. 

import Foundation

let array1 = [1,2,3]
let array2 = [1,2,3,4,5]
let array3 = [12,11,10,9,8,7,6,5,4,3,2]
let array4 = [Int]()
let array5 = [1]
let array6 = [1,2]

func middleThree(array: [Int]) -> [Int] {
  let length = count(array)
  if length < 3 || length%2 == 0 { return [Int]() }
  let mid = (length-1)/2
  return [array[mid-1], array[mid], array[mid+1]]
}

middleThree(array1)
middleThree(array2)
middleThree(array3)
middleThree(array4)
middleThree(array5)
middleThree(array6)
