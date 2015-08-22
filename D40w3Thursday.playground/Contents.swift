// Code Challenge: Given a string, return a string where for every char in the original, there are two chars.
// Example: doubleChar("The") → "TThhee"

import Foundation

let string1 = "The"
let string2 = ""
let string3 = "X"
let string4 = "😡😎😥"

func doubleChar(string: String) -> String {
  var result = [Character]()
  for character in string {
    result += [character, character]
  }
  return String(result)
}

doubleChar(string1)
doubleChar(string2)
doubleChar(string3)
doubleChar(string4)
