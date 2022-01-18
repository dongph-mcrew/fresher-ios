//
//  RestaurantViewModel.swift
//  Day11_ExampleApp
//
//  Created by Hao Lam on 1/18/22.
//

import Foundation


struct RestaurantViewModel {
    
    private let restaurant : Restaurant
    var displayText : String {
        return restaurant.name + " - " +  restaurant.cuisine.rawValue.capitalized
    }
    
    init (restaurant : Restaurant) {
        self.restaurant = restaurant
    }
}
