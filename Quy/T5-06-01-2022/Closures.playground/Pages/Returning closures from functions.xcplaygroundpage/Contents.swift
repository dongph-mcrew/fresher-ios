//: [Previous](@previous)

import Foundation

func travel() -> ((String)->Void) {
    return { print("I'm going to \($0)") }
}

let message = travel()

//indirect call
message("London")
//direct call
travel()("London")

//: [Next](@next)
