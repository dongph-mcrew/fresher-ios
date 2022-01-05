//: [Previous](@previous)

import Foundation

var countdown = 10

while countdown >= 0 {
    print(countdown)
    countdown -= 1
    
    if countdown == 4 {
        print("I'm bored. Let's go now")
        break //The break line is used to exit out of the loop
    }
}
print(" Blast off ")

//: [Next](@next)
