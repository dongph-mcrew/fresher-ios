//: [Previous](@previous)

import Foundation

protocol Identifiable {
    var id: String { get set }
    func identify()
}
extension Identifiable {
    func identify() {
        print("My id is: \(id)")
    }
}

struct User: Identifiable {
    var id: String
}
let dave = User(id: "Dave")
dave.identify()
//: [Next](@next)
