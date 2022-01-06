//: [Previous](@previous)

import Foundation

struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var john = Person(name: "John")
john.makeAnonymous()
/*:
 Note:
    +Mutating function can only be called if the property that it's mutating is a variable & the instance of the struct is also a variable.
    +Only a variable instances of a struct can call a mutating function.
    +If you call function that calls a mutating function then you must mark both as mutating.
 */
//: [Next](@next)
