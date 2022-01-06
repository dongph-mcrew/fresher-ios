//: [Previous](@previous)

import Foundation
/*
 Switch statement is used to check all conditions. Which mean that you must have all possible cases inside it or have a default case.
 The default in Switch statement is relegated to check all the other conditions that can occur which hasn't been listed inside the switch statement.
 Switch statement in Swift work by matching the conditions with its case then exit out of the switch without fallthrough. If u want to enable it u can use fallthrough on any case.
 Every case inside a switch statement must have at least 1 executable code. If you don't want to do anything in a case use break.
 */

let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Bring some sunscreen")
default:
    print("Enjoy your day")
}
/*
 Switch statement is used in place of if-else in case of checking a value with multiple different state.
 */

//: [Next](@next)
