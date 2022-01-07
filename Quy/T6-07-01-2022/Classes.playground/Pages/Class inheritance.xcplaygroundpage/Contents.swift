//: [Previous](@previous)

import Foundation

class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) { // (*)
        self.name = name
        self.breed = breed
    }
}

class Poodle: Dog { ///Subclassing the Dog class.
    init(name: String) {
        super.init(name: name, breed: "Poodle") ///Calling the dog class init (*)
    }
}

let poppy = Poodle(name: "Poppy")
print(poppy.breed + ": " + poppy.name)

/*:
 Note: Swift required child classes to call super.init in case there is some important work to be done when creating parent classes.
 */
//: [Next](@next)
