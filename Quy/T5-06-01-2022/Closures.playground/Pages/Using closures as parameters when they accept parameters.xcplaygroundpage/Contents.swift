//: [Previous](@previous)

import Foundation

func travel(action: (String)->Void ) { 
    print("I'm getting ready to go")
    action("London") ///Give the closure value
    print("I have arrived")
}

travel { (place) in
    print("I'm driving to \(place)") ///Calling the value
}
//: [Next](@next)
