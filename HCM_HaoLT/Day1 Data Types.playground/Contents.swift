import UIKit
import Darwin
import CoreFoundation


//1. VAR
/*
 Once you create a variable using var, you can change it as often as you want without using var again.

 */
var greeting = "Hello, playground"
greeting = "Hello Swift"
greeting = "Hello"

/*
 - We can declare a variable without defining its type
 - We CAN'T change its type later on
 */


//2. String, Int & Double & Type safe language

/*
- If you have large numbers, Swift lets you use underscores as thousands separators – they don’t change the number, but they do make it easier to read.
*/
var population  = 8_000_000


/*
- Swift decides whether to consider it an integer or a double based on whether you include a decimal point.
- We can't write var total = myInt + myDouble.  It isn’t allowed!
 */
var myInt = 9
var myDouble = 9.0


/*
- Multi-Line String: start and end with three double quote marks
 */
var str = """
    Open and closing triple quote
    must be on their own line
    by themselves

    We can use a \
    to go to new line
    inside the string
"""


// 3. String Interpolation
/*
- String interpolation allows you to create strings from other variables and constants, placing their values inside your string.
*/
var store = "Starbucks"
var hour = 10
var message = "Welcom to \(store)! We open at \(hour) AM every morning"

/*
- We can we can extend String.StringInterpolation to add our own custom interpolations
 */
let age = 38
extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut

        if let result = formatter.string(from: value as NSNumber) {
            appendLiteral(result)
        }
    }
    mutating func appendInterpolation(_ value: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .full

        let dateString = formatter.string(from: value)
        appendLiteral(dateString)
    }
}

print("I'm \(age)") // Print out: I'm thirty-eight
print("Today date: \(Date())") // Print out: Today date: Tuesday, January 4, 2022

// 5. Constants & Type annotation

/*
 - Use 'let' to declare constant - value that can be set once and never again
 */

let myNum = 10

/*
 - Type annotation: We can explicitly declare value type
 */
let myNum2 : Int = 20
let myNum3 : String = "50"
let myNum4 : Double

/*
 Reason to have type annotation:
 1. In advanced code, Swift can’t know that ahead of time the type, so you’ll need to tell it.
 2. Casting value to specific type
 3. You want to tell Swift that a variable is going to exist, but you don’t want to set its value just yet.
 */


// 6. Array

/*
 - Array positions count from 0
 - If you’re using type annotations, arrays are written in brackets: [String], [Int], [Double], and [Bool].
 */
 
var myArr : [Double]
var myArr2 : [Int] = [ 1,2,3]


// 7. Set

/*
  - Set is used to store UNIQUE + UNORDERED values
 1. Items aren’t stored in any order; they are stored in what is effectively a random order.
 2. Item can't appear twice in a set; all items must be unique.
 3. Can’t read values from a set using numerical positions like with arrays, because they are unordered
 */
let mySet = Set([1,2,3]) //create a set directly from  arrays
let mySet1 = Set([[1,2,3], [4,5,6]])
let mySet2: Set = ["a", "b", "c", "d"]
mySet2[mySet2.index(mySet2.startIndex, offsetBy: 2)] // -> get value "c" by index from the set.

/* - If you try to insert a duplicate item into a set, the duplicates get ignored.*/
let mySet3 : Set = ["blue", "red", "yellow", "yellow", "blue", "orange"]
mySet3

//8. Tupples

/*
 - Specific, FIXED collection of related values where each item has a precise position or name
 - Cannot change or remove item later on
 - You can change the values inside a tuple after you create it, but NOT the TYPES of values
 - We can hold different type of values inside a tupple such as Int, String, Double,...
 */

let myTup = (name : "Jane" , age: 28, score: 9.8)
var str2 = "\(myTup.name) is \(myTup.age) years old - Score: \(myTup.score)"


//9. Dictionary

/*
 Use a colon to separate the value you want to store (e.g. 1.78) from the identifier you want to store it under (e.g. “Taylor Swift”).
 */

let heights = [
    "Tom" : 1.77,
    "Rachel" : 1.65
]
print("Rachel's height : \(heights["Tom"]!) ")


//10.Empty collections

/*
- Arrays, sets, and dictionaries are called collections
 
- If you want to create an empty collection just write its type followed by opening and closing parentheses.
 */

var myScores = [String : Int]() //dictionary
var myArray = [Double]() //array

//Swift has special syntax only for dictionaries and arrays; other types must use angle bracket syntax like sets.
var mySet5 = Set<Int>()  //set is done slightly different
var mySet6 = Set<String>()


//11. Enumerations

enum result {
    case sucess
    case fail
}

var myResult = result.sucess

/*
 - Enum Associated Value
 */

enum activity {
    case walking (to: String)
    case talking (with: String)
    case learning (subject: String)
    case counting (to: Int)
}
let person1 = activity.counting(to: 10)
let person2 = activity.learning(subject: "Math")

/*
 - Enum raw values: You can attach raw values to enums so they can be created from integers or strings
 
 + Swift will automatically assign each of those a number starting from 0
 + We also can assign one or more cases a specific value, and Swift will generate the rest.

 */

enum planet : Int {
    case mercury = 1
    case venus
    case earth
    
}
let earth = planet(rawValue: 3) //earth

enum event : String {
    case login = "logged_in"
    case logout = "logged_out"
    case optCheck = "optSent"
}

let state = "optSent"
let status = event(rawValue: state )


/*
 - Comparable enum:
 */

enum Sizes: Comparable {
    case small  //0
    case medium //1
    case large  //2
}
let first = Sizes.small
let second = Sizes.large
print (first < second) // true
