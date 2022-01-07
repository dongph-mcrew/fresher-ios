//: [Previous](@previous)

import Foundation

final class Dog { ///final == uninheritable
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

/*:
 Note: final label use case is largely just to make clear the intent of not modifying the class.
 */
//: [Next](@next)
