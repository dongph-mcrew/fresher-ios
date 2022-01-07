//: [Previous](@previous)

import Foundation

class Person {
    var name: String
    
    init(name: String) {
        self.name = name
        print("\(name) is alive")
    }
    
    func greet() {
        print("Hello I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more")
    }
}

let getIn = ["Putin", "Rasputin", "Lenin", "Stalin"]

for getOut in getIn {
    let person = Person(name: getOut)
    person.greet()
}

/*:
 Note:
    +Classes use deinit because of its copy mechanic. Swift uses ARC to count how many copy point to the same class. When the copy goes to 0 the deinitializers is called to destroy it.
    +Structs copying is basically just make a new object so they don't need deinit. The struct gets destroyed when the object that owns its is no more.
 */
//: [Next](@next)
