//: [Previous](@previous)

import Foundation

struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

/*:
 Note: failable init are used to check for a valid object at the time of creation to skip calling separate methods to checks.
 */
//: [Next](@next)
