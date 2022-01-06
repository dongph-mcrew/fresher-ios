//: [Previous](@previous)

import Foundation

func travel(action: (String,Int)->String) {
    print("I'm getting ready to go")
    let description = action("London", 60)
    print(description)
    print("I arrived")
}

travel { "I'm going to \($0) at \($1) m/h" } ///The automatic name start from 0.

//: [Next](@next)
