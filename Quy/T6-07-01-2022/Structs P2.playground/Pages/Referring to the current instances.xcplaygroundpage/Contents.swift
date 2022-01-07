//: [Previous](@previous)

import Foundation

struct Person {
    var name: String
    
    init(name: String) {
        self.name = name
        ///self help distinguish between the current instances name property and the parameter name.
    }
}

/*:
 Note: self isn't limited to init. You can use it inside any method that needs a reference to the current struct instance.
 */
//: [Next](@next)
