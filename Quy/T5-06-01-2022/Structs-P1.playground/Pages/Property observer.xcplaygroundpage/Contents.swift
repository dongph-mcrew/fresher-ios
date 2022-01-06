//: [Previous](@previous)

import Foundation

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(amount)%")
        }
    }
}

var loading = Progress(task: "Loading Data", amount: 0)
loading.amount = 30
loading.amount = 50
loading.amount = 100

/*:
 Note:
    +You can call a property inside a property observer. But you
    shouldn't call a computed property inside it getter or setter
    +didSet is after the property has set it value, willSet is before the property will set the value
    +You can access the old value in didSet with the constant oldValue, and the reverse for willSet with newValue
    +You can change the constant name for willSet and didSet.
 */

struct Dummy {
    var name: String {
        didSet {
            print("This call is after the new value was set, oldValue: \(oldValue), newValue: \(name)")
        }
        willSet {
            print("This call is before the new value will be set, newValue: \(newValue), oldValue: \(name)")
        }
    }
    var age: Int {
        didSet(numberAfter) {
            print("This is the new age \(numberAfter)")
        }
        willSet(numberBefore) {
            print(("This is the old age \(numberBefore)"))
        }
    }
}

var dummy = Dummy(name: "Tim Cook", age: 69)
dummy.name = "Tim Apple"
dummy.age = 99
//: [Next](@next)
