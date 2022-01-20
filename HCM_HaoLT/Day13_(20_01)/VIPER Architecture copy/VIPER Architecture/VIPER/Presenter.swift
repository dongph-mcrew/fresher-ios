//
//  Presenter.swift
//  VIPER Architecture
//
//  Created by Hao Lam on 1/20/22.
//

import Foundation


/*
    Presenter has a reference to :
        + interactor
        + router
        + view
*/

enum FetchError : Error {
    case failed
}

protocol AnyPresenter {
    //reference to interactor , router and view:
    var router : AnyRouter? {get set }
    var interactor : AnyInteractor? { get set }
    var view : AnyView? { get set }
    
    //interactor performs some interactions & hand the result to presenter
    // therefore, we need a function to catch it here!
    func interactorDidFetchUsers(with result : Result<[User], Error> )
}

class UserPresenter : AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            //once the instance of the interactor is set, we call get users
            interactor?.getUsers()
        }
    }
    
    var view: AnyView?
    
  
    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
         
        switch result {
            
        case .success(let users) :
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went wrong")
        }
        
    }
    
    
}
