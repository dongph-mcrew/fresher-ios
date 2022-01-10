//: [Previous](@previous)

import Foundation

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

try! checkPassword("sekrit")
print("Ok!")

/*:
 Note:
    +Optionals try are used for when you don't care about the error and only if the code work or not.
    +Optionals try function is used to convert throwing function calls into optionals calls that doesn't interact with any error if it get thrown an error.
 */
//: [Next](@next)
