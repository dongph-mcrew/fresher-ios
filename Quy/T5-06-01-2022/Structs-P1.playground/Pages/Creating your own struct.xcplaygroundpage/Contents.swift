import Cocoa

struct Tennis {
    var name: String
}

var tennis = Tennis(name: "Tennis")
///If you change any property of a object then you must declare that object as a variable.
tennis.name = "Lawn tennis"

/*:
 Note: Tuples are like anonymous Structs. Tuples are great for one off use case. Structs are for multiple calls use case.
 */
