//: [Previous](@previous)

import Foundation

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
} else if age1 > 18 || age2 > 18 {
    print("At least 1 is over 18")
} 

/*
 When writing multiple conditions it best to use parentheses to separate conditions to make the condition clear.
 When checking condition with a boolean you can check with just the boolean .This work because If will automatically check booleans.
 */
let bool = age1 < 18 && age2 < 18
if bool {
    print("Both are under 18")
}

//: [Next](@next)
