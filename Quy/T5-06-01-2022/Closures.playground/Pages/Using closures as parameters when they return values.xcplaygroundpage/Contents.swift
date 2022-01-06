//: [Previous](@previous)

import Foundation

func travel(action: (String)->String) {
    print("I'm getting ready to move")
    let description = action("London")
    print(description)
    print("I have arrived")
}

travel { (place: String) in
    return ("I'm traveling to \(place)")
}

//Bonus example for reduce()

func reduce(_ values: [Int], using closures: (Int,Int)->Int) -> Int {
    //start with a total equal to the first value
    var current = values[0] ///If the array is empty this line will crash.
    
    //loop over all values in the array, counting from index 1 onwards.
    for value in values[1...] {
        //call our closures with the current value and the array element, assigning its result to our current value.
        current = closures(current, value)
    }
    //return the final value
    return current
}

let array = [1,2,3,4]
//full version
let sum = reduce(array) { (runningTotal:Int, next:Int) -> Int in
    return runningTotal + next
}

//shortened version
let shortSum = reduce(array) { $0 + $1 }

//simplest version
let operatorSum = reduce(array, using: +) /// (+) operator is a short hand for a function of type (Int,Int)->Int so this works.

//: [Next](@next)
