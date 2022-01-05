//: [Previous](@previous)

import Foundation
//Making a function with a return value.
func square(number: Int) -> Int {
    return number * number
}

let result = square(number: 8)
print(result)

/*:
 The return function can be omitted if the function is a single expression (single line)
 List of things that aren't a single expression:
    +statements
    +loops
    +conditions
    +new variable declaration
 Exception: Ternary Operator.
 */
func greeting(name: String) -> String {
    name == "Taylor Swift" ? "Oh wow" : "Hello \(name)"
}
//: [Next](@next)
