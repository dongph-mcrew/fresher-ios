//: [Previous](@previous)

import Foundation

let drivingWithReturn = { (place: String) -> String in
    return ("I'm driving to \(place)")
}

let message = drivingWithReturn("Paris")
print(message)

/*:
 Note: To write a closure without any parameter or return value you write like this () -> () 
 */
//: [Next](@next)
