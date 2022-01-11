import Cocoa

//Defining a protocol.
protocol Identifiable {
    var id: String { get set }
}
//conform a struct to a protocol
struct User: Identifiable {
    var id: String
}
//define a function that can take any type that conformed to the protocol.
func displayID(thing: Identifiable) {
    print("My id is \(thing.id)")
}

protocol Cleaning {
    func clean()
}

struct Man {
    var delegate: Cleaning?
}

struct Roomba: Cleaning {
    func clean() {
        //vacuuming the house
    }
}

var luke = Man()
let r2d2 = Roomba()
luke.delegate = r2d2
luke.delegate?.clean() //Turn on the roomba.

