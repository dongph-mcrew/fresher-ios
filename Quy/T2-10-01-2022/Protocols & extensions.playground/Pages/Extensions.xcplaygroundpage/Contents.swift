//: [Previous](@previous)

import Foundation

extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 8
number.squared()

//Swift only allow computed property inside of extension. Stored property is not allowed.
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

number.isEven

protocol Lumberjack {
    func chopWood()
}

struct Woody {
    let name = "Woody"
}
extension Woody: Lumberjack {
    func chopWood() {
        //Chopping wood
    }
}
//: [Next](@next)
