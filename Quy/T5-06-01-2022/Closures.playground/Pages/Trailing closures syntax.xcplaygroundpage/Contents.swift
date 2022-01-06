//: [Previous](@previous)

import Foundation
///Rule: If a closure is the last parameter in a function then it can be a trailing closure.

func travel(action: ()->Void) {
    print("I'm getting ready to go")
    action()
    print("I have arrived")
}

travel { ///The parentheses can be ommitted if there is only a single parameter and it's a closure.
    print("I'm driving my car")
}

//: [Next](@next)
