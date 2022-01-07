//: [Previous](@previous)

import Foundation

class Singer {
    var name = "Taylor Swift"
}

let taylor = Singer()
taylor.name = "Ed Sheeran" ///A constant class variable property can be changed. This isn't true immutability.

class Driver {
    let name = "John Tanner"
}

var tanner = Driver()
//tanner.name = "Tobias Jones" //Invalid.
///To make a property immutable in a class the property have to be a constant.

/*:
 Note:
    +A constant struct that has a constant property cannot change that property because doing so would means destroying that struct and replace it with a new one which isn't what a constant struct is about. With class the property can be changed freely.
 */
//: [Next](@next)
