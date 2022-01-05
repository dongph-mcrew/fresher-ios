import Cocoa

let firstScore = 12
let secondScore = 4

//Add & subtract

let sum = firstScore + secondScore
let diff = firstScore - secondScore

//Multiply & divide

let product = firstScore * secondScore
let divided = firstScore / secondScore

/*
 The % operators is used in Swift to calculate how many time a number can fit inside another number
 */
let remainder = 13 % secondScore
///4 can fit 3 times inside 13 with the remainder of 1

/*
 Why can't u add an Int to a Double? The answer is because with Int it can represent a large number very precisely but it can't represent a small fraction number. The reverse is true for Double, although it can show small number very precisely it precision is decreased with increasingly large number.
 */

let weeks = 465 / 7
let days = 465 % 7
print("There are \(weeks) week and \(days) day left")


