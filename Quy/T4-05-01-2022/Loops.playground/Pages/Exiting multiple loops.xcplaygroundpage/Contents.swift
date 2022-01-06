//: [Previous](@previous)

import Foundation
/*
 To Exit a nested loop you can give the label for the outer loop. Then to exit simply call break with the outer loop label.
 If you call break on a loop nested inside another loop it will just simply exit out to the outer loop
 */

outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) = \(product)")
        if product == 50 {
            print("It's a bullseye")
            break outerLoop
        }
    }
}
//Bonus example
let options = ["up", "down", "left", "right"]

let password = ["down", "right", "right"]

outerLoop: for p1 in options {
    for p2 in options {
        for p3 in options {
            print("In loops")
            let attemp = [p1, p2, p3]
            
            if attemp == password {
                print("The pass word is \(attemp)")
                break outerLoop
            }
        }
    }
}

//: [Next](@next)
