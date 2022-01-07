import Cocoa

struct User {
    var name: String
    
    init() {
        name = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
user.name = "Quy"

/*
 Note:
    +All struct have a default initializer called a memberwise init. To use it the struct must have no initializer.
    +If a struct property have default values then you can exclude it from the memberwise init.
    +In order to keep a memberwise init with making custom init you can make them in the extension of the struct.
 */
