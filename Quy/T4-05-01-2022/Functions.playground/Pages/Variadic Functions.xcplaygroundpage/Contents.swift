//: [Previous](@previous)

import Foundation

/*
 Variadic function is a function that take in multiple parameter of the same type into a single array parameter.
 */

print("Haters", "gonna", "hate")
// This is a variadic functions that print all elements into a single line with spaces between.

func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
square(numbers: 1, 2, 3, 4, 5)

/*
 Variadic functions are used to add more functionality to a functions.
 */

//: [Next](@next)
