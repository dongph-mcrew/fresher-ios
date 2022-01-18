//
//  AppCoordinator.swift
//  Day11_ExampleApp
//
//  Created by Hao Lam on 1/18/22.
//

import Foundation
import UIKit

class AppCoordinator {
    
    private let window : UIWindow
    init (window : UIWindow) {
        self.window = window
    }
    func start() {
       
        //create view controller
        let viewController = ViewController.instantiate(viewModel: RestaunrantsListViewModel())
       
        //put the view controller into navigation controller
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
