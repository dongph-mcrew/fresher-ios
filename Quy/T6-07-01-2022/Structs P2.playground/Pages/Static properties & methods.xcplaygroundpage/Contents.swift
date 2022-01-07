//: [Previous](@previous)

import Foundation

struct Student {
    static var classSize = 0
    var name: String
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let ed = Student(name: "Ed")
let taylor = Student(name: "Taylor")

print(Student.classSize)
/*:
 Note: Static is mainly used to make commonly used property and method accessible in an entire app.
 */
//: [Next](@next)
