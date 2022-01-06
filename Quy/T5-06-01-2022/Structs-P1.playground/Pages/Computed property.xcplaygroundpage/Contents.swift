//: [Previous](@previous)

import Foundation

struct Sport {
    var name: String
    var isOlympicSport: Bool
    
    var isOlympicStatus: String {
        isOlympicSport ? "\(name) is an olympic sport" : "\(name) is not an olympic sport"
    }
    
    var status: Bool {
        isOlympicStatus.isEmpty
    }
}

let chessBoxing = Sport(name: "Chess Boxing", isOlympicSport: false)

print(chessBoxing.isOlympicStatus)
print(chessBoxing.status)
//: [Next](@next)
