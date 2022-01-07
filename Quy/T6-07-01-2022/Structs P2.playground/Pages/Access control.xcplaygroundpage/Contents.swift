//: [Previous](@previous)

import Foundation

struct Person {
    private var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        "My social security number is \(id)"
    }
}

let ed = Person(id: "1234")
print(ed.identify())

/*:
 Note:
    +You cannot use a memberwise init to create a property that has restricted access control. You have to create a custom init to create it.
    +The default access level for all item in a project is internal. internal scope is the whole project.
    +Restricted access control: file-private (scope is the same file), private (scope is the parentheses that contain that item)
 */
//: [Next](@next)
