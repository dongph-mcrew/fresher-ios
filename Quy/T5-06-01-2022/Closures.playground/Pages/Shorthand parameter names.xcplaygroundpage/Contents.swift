//: [Previous](@previous)

import Foundation


func travel(action: (String)->String) {
    print("I'm getting ready to go")
    let description = action("London")
    print(description)
    print("I arrived")
}
//long version

travel() { (place: String) -> String in
    return ("I'm driving to \(place)")
}
//short version using automatic name for parameter

travel { "I'm driving to \($0)"} 

/*:
 Note: The rules for writing short closures:
    +In the parameter section of a closure you can omit it's type annotation because Swift can infer the type. (Sometimes swift can't infer the type if the type is too vague), the same is also true for it's return type and ->.
    +The return can be omitted if the closure contain a single expression just like function.
    +If you use automatic name for parameter then you can omit (in).
    +If you use trailing closures with a function that takes a single closure as it parameter then you can omit the function parentheses ().
 */
//: [Next](@next)
