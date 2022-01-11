//: [Previous](@previous)

import Foundation

func username(for id: Int) -> String? {
    return id == 1 ? "Taylor Swift" : nil
}

let user = username(for: 15) ?? "Anonymous"

/*:
 You can chain nil coalesing like so: first() ?? second() ?? ""
 to make it so when first returns nil then second will be executed and if second return nil then the value will be "".
 */
//: [Next](@next)
