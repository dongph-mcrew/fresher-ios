//
//  Restaurant.swift
//  Day11_ExampleApp
//
//  Created by Hao Lam on 1/18/22.
//

import Foundation


struct Restaurant : Decodable {
    let name : String
    let cuisine : Cuisine
}

enum Cuisine : String, Decodable {
    case French
    case European
    case American
    case English
    case Chinese
    case Mexican
}
