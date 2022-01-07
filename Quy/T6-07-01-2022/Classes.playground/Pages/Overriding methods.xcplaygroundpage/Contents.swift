//: [Previous](@previous)

import Foundation

class Dog {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func bark() {
        print("Woof!")
    }
}

class Poodle: Dog {
    override var name: String {
        didSet {
            print("The poodle name is: \(name)")
        }
    }
    
    override func bark() {
        super.bark() ///calling the super class implementation of the methods
        print("Yip!") ///new implementation
    }
}

var rosie = Poodle(name: "Rosie")
rosie.bark()
rosie.name = "Lil' Rosie"

/*:
 Note:
    +Override label is usually used to mark that a child class is making its own implementation of the method or property.
    +You cannot override a stored property of a super class into a stored property. But you can override it into a computed property or add propety observer to it.
 */
//: [Next](@next)
