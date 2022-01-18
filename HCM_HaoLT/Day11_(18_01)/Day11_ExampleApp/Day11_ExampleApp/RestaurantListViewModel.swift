//
//  RestaurantListViewModel.swift
//  Day11_ExampleApp
//
//  Created by Hao Lam on 1/18/22.
//

import Foundation
import RxSwift

final class RestaunrantsListViewModel {
    
    let title = "Restaurant"
    
    private let restaurantService : RestaurantServiceProtocol
    
    init(restaurantService : RestaurantServiceProtocol = RestaurantService() ){
        self.restaurantService = restaurantService
    }
    
    func fetchRestaurantViewModels() -> Observable<[RestaurantViewModel]>{
        restaurantService.fetchRestaurants()
            .map {
                //acess array of restaurant
                $0.map {
                    //map through the array, acess each item
                    RestaurantViewModel(restaurant: $0)
                }
            }
        
    }
}
