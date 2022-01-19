//
//  RestaurantService.swift
//  Day11_ExampleApp
//
//  Created by Hao Lam on 1/18/22.
//

import Foundation
import RxSwift

protocol RestaurantServiceProtocol {
    func fetchRestaurants() -> Observable<[Restaurant]>
}

class RestaurantService : RestaurantServiceProtocol {
    
    func fetchRestaurants() -> Observable<[Restaurant]> {
        
        return Observable.create { observer -> Disposable in
            guard let path = Bundle.main.path(forResource: "restaurant", ofType: "json")
            else {
                //send error if not found the file
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create{ } //return an empty disposable
            }
            
            //read the file from path
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                //format to restaurant object with JSONDecoder
                let restaurants =  try JSONDecoder().decode([Restaurant].self, from: data)

                observer.onNext(restaurants)
            }
            catch {
                //catch error
                observer.onError(error)
            }
            return Disposables.create{ } //return an empty disposable
        }
    }
}
