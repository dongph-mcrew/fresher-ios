//
//  Router.swift
//  VIPER Architecture
//
//  Created by Hao Lam on 1/20/22.
//

import Foundation
import UIKit

/*
 There are different modules in the application,
 AND the router can route within its own model
 => It is the entry point for our modules. This is where the VIPER arch starts
 => This is how we're going to get the entrance view controller in scene delegate momentarily
 
 
 EX: An app with 5 tabs -> each tabs is a module
 
*/
typealias EntryPoint = AnyView & UIViewController
protocol AnyRouter {
    
    var entry : EntryPoint? {get}
    static func start() -> AnyRouter
}


class UserRouter : AnyRouter {

    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        //create all components of viber and return it
        let router = UserRouter()
        
        //Assign VIP
        var view: AnyView = UserViewController()
        
        var presenter : AnyPresenter = UserPresenter()
        
        var interactor : AnyInteractor = UserInteractor ()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        
        presenter.view = view
        
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        return router
        
    }
}

