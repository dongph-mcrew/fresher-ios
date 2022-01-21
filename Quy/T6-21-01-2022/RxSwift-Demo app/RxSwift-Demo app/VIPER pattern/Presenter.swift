//
//  Presenter.swift
//  RxSwift-Demo app
//
//  Created by Mcrew-Tech on 21/01/2022.
//

import Foundation
import RxSwift

//Object
//protocol
//ref to Interactor, View, Router

protocol AnyPresenter {
    var view: AnyView? { get set }
    var interactor: AnyInteractor? { get set }
    var router: AnyRouter? { get set }
    
    var output: PublishSubject<[User]> { get set }
    
    func showNextScreen()
    func viewDidLoad()
    func interactorDidFetchUser(with: Result<[User], FetchError>)
}

enum FetchError: Error {
    case failed
}

class Presenter: AnyPresenter {
    var output = PublishSubject<[User]> ()
    
    var view: AnyView?
    
    var interactor: AnyInteractor?
    
    var router: AnyRouter?
    
    func showNextScreen() {
        if let safeView = view as? ViewController {
            router?.goToNextScreen(from: safeView)
        }
    }
    
    func viewDidLoad() {
        interactor?.getUserList()
    }
    
    func interactorDidFetchUser(with result: Result<[User], FetchError>) {
        switch result {
        case .failure(let error):
            view?.update(error: error)
        case .success(let users):
            view?.update(success: users)
        }
    }
    
    deinit {
        print("Presenter deinit")
    }
}
