//: [Previous](@previous)

import Foundation

struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct Person {
    var name: String
    lazy var familyTree = FamilyTree() ///The lazy property will only be created if it is accessed once.
    
    init(name: String) {
        self.name = name
    }
}

var ed = Person(name: "Ed")
ed.familyTree

/*:
 Note:
    +The benefit of using lazy property is to be used with property that aren't needed until it's called and help with performance.
    +The difference between lazy & computed property is computed property doesn't keep it value where as with lazy property if you had created it then it will cache it value.
 */
//: [Next](@next)
