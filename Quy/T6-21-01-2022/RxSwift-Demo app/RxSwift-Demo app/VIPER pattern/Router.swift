//
//  Router.swift
//  RxSwift-Demo app
//
//  Created by Mcrew-Tech on 21/01/2022.
//

import Foundation
import UIKit

//Object
//Protocol
//ref to entry view

protocol AnyRouter {
    static func build(with entry: AnyView)
    func goToNextScreen(from view: EntryView)
}

typealias EntryView = UIViewController & AnyView

class Router: AnyRouter {
                
    class func build(with entry: AnyView) {
        let router = Router()
        let presenter = Presenter()
        let interactor = Interactor()
        
        var localView = entry
        
        interactor.presenter = presenter
        localView.presenter = presenter
        
        presenter.view = localView
        presenter.interactor = interactor
        presenter.router = router
    }
    
    func goToNextScreen(from view: EntryView) {        
        let diffView = view
            .storyboard?
            .instantiateViewController(identifier: "diffVC")
            as! DiffViewController
        view
            .navigationController?
            .pushViewController(diffView, animated: true)
    }
    
    deinit {
        print("Router deinit")
    }
}
