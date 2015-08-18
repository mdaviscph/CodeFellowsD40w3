// Code Challenge: Given a non-negative number "num", return true if num is within 2 of a multiple of 10. Note: (a % b) is the remainder of dividing a by b, so (7 % 5) is 2

import Foundation


func isNonNegativeNumberNearMultiple(number: UInt, #within: UInt, #multiple: UInt) -> Bool {
  let remainder = number % multiple
  return remainder <= within || remainder >= multiple - within
}

isNonNegativeNumberNearMultiple(13, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(12, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(11, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(10, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(9, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(8, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(7, within: 2, multiple: 10)

isNonNegativeNumberNearMultiple(2, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(1, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(0, within: 2, multiple: 10)

isNonNegativeNumberNearMultiple(73, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(72, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(71, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(70, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(69, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(68, within: 2, multiple: 10)
isNonNegativeNumberNearMultiple(67, within: 2, multiple: 10)
