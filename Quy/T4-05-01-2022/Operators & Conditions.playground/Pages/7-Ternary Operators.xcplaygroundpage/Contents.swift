//: [Previous](@previous)

import Foundation
/*
 Ternary operator is like a shorthand version of an if-else. It has a condition block follow with a true or false execution blocks.
 The ordering is condition ? true block : false block
 */

let firstCard = 11
let secondCard = 10

print(firstCard == secondCard ? "The same card" : "Different card")

//If else version
if firstCard == secondCard {
    "The same card"
} else {
    "Different card"
}
//: [Next](@next)
