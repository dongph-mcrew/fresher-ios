//: [Previous](@previous)

import Foundation

/*:
 Note:
    +The in command signal the start of the body of a closure
    +Unlike functions, closures don't use parameter label.
 */

let driving = { (place: String) in
    print("I'm driving to \(place)")
}

driving("Paris")
//: [Next](@next)
