import Cocoa

class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let seymour = Dog(name: "Seymour Asses", breed: "Border terrier")
print("name: \(seymour.name), breed: \(seymour.breed)")

/*:
 Note:
    +Unlike structs, classes have no memberwise init. They also are reference type so with structs every single one is unique where as every class all point to the same source. This is why structs are more widely used because it's much safer to change structs then it is with classes.
    +Other differences: Deinit, not immutable.
 */
