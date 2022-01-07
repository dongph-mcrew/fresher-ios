//: [Previous](@previous)

import Foundation

class Singer {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let freddy = Singer(name: "Freddy Mercury")
print(freddy.name)

var miley = freddy ///copying freddy pointer to miley, now they both point to the same object.
miley.name = "Miley Cyrus" ///altering the reference name property.

print(freddy.name)

/*:
 Note:
    +Copying with structs: create a new object with the same values.
    +Copying with classes: create a new pointer which point to the same object.
 */
//: [Next](@next)
