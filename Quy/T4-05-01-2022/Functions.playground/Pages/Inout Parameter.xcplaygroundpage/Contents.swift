//: [Previous](@previous)

import Foundation

func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 12

doubleInPlace(number: &myNum)

func twice(number: inout Int, another: inout Int) {
    number * another
}

//twice(number: &myNum, another: &myNum)

/*
 To use inout:
    +The input must be a variable to modify it
    +The parameter must have inout
    +The name of the input must have & before to signafy inout.
 Note: a function with 2 inout parameter of the same type cannot use the same input because it will create overlapping access to the same variable.
 */
//: [Next](@next)
