//: [Previous](@previous)

import Foundation

func travel() -> (String) -> Void {
    var counter = 1 ///The variable is captured inside the closure.
    return {
        print("\(counter) I'm going to \($0)")
        counter += 1
    }
}

let result = travel()

result("London")
result("London")
result("London")

///Closure can capture anything, even other closures. Note that it can create a strong reference.
var outside = 0

let closure = {
    print("\(outside)")
    outside += 1
}

closure()
closure()
closure()

//: [Next](@next)
