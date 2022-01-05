//: [Previous](@previous)

import Foundation

enum PasswordError: Error { ///All error must subclass Error type
    case obvious
    case simple
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    } else if password == "1234" {
        throw PasswordError.simple
    }
    
    return true
}

do {
    try checkPassword("password")
    print("That password is good") //The code won't execute because of error causing the executiton to go to the catch block
} catch {
    print("That password is no good")
}

/*
 Note:
    +In catch block you can condition different execution for each error like a switch statements, with catch acts as a default case.
    +In catch block it generally gives you an error of type Error that is caught in that catch block
*/

do {
    try checkPassword("1234")
} catch PasswordError.obvious {
    print("Obvious Password")
} catch PasswordError.simple {
    print("Too simple")
}

//: [Next](@next)
