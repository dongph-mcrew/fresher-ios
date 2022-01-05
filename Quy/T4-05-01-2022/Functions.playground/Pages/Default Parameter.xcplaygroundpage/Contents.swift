//: [Previous](@previous)

import Foundation

func greet(_ person: String, nicely: Bool = true) {
    if nicely {
        print("Hello \(person)")
    } else {
        print("Oh no, it's \(person) again..")
    }
}

greet("Taylor")
greet("Taylor", nicely: false)
/*:
 Default parameter is used mostly to provide a default value to use in most cases with the added benefit of flexibility to change whenever.
 */
//: [Next](@next)
