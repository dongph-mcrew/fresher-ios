//: [Previous](@previous)

import Foundation

let drive = {
    print("I'm driving my car")
}

func travel(action: ()->Void) { /// ()->() also works
    print("I'm getting ready to go")
    action()
    print("I have arrived")
}

travel(action: drive)
//: [Next](@next)
