//: [Previous](@previous)

import Foundation
//Half-open range operator (..<) create a range that goes from the left side value up to but excluding the right side value.
//Closed range operator (...) creates a range that includes the right side value.
///Note:
/// The left side of the operator must always have lower value then the value on the right side.

let score = 85

switch score {
case 0..<50:
    print("You failed badly")
case 50..<85:
    print("You did Ok")
default:
    print("You did great")
}

let array = [1,2,3,4,5,6,7,8]
let subArray = array[1...5]
let halfArray = array[4...] ///You can use half range in subscript to get to the end of an array.


/*
 Ranges can also be used in subscript. With String you can make substring (But you need to use String.Index range instead of regular range with Int)
 */

//: [Next](@next)
