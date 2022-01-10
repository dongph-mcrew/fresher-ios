//: [Previous](@previous)

import Foundation

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()

protocol Avian {
    var legs: Int { get set }
    func fly()
}
extension Avian {
    func fly() {}
}

struct Chicken: Avian {
    var legs: Int = 2
}

let jones = Chicken()
jones.fly()

/* Note:
 +You can use extension to add protocol conformance to other type.
 +You can use protocol conditional conformance to make swift synthesize the conformance. Ex:
 
     extension Array: Purchaseable where Element: Purchaseable {
        //The array will conform to Purchaseable whenever all it's element are Purchasable.
         func buy() {
             for item in self {
                 item.buy()
             }
         }
     }
 
 +Protocol extension can be used to make the code tidier and easier to look at.
 
 */
//: [Next](@next)
