//: [Previous](@previous)

import Foundation
import Darwin

class Animal {}

class Fish: Animal {}

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

let pets = [Fish(), Dog(), Fish(), Dog()]

for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}

//You can also type cast in switch case
//switch for each type
for pet in pets {
    switch pet {
    case is Dog:
        (pet as? Dog)?.makeNoise()
    default:
        break
    }
}

//switch with type casting
for pet in pets {
    switch pet {
    case let dog as Dog:
        dog.makeNoise()
    default:
        break
    }
}

let data: Int
data as Double
//: [Next](@next)
