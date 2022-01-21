//
//  MovieList_Router.swift
//  ViperMovie
//
//  Created by Hao Lam on 1/21/22.
//

import Foundation
import UIKit

class MovieList_Router : PresenterToRouter_MovieList_Protocol {
    static func createModule() -> UINavigationController? {
        //Creating complete package with nested dependency
            // This all should come from a Factory >> DI
        
            let viewController = MovieList_ViewController()
        
            let navigationController = UINavigationController(rootViewController: viewController)
            
            let presenter : ViewToPresenter_MovieList_Protocol &
                            InteractorToPresenter_MovieList_Protocol = MovieList_Presenter()
            
            viewController.presenter = presenter
            viewController.presenter?.router = MovieList_Router()
            viewController.presenter?.view = viewController
            viewController.presenter?.interactor = MovieList_Interactor()
            ///assign presenter property of interactor object
            viewController.presenter?.interactor?.presenter = presenter
            
            return navigationController
 
        
    }
    
    func pushToMovieDetail(on view: PresenterToView_MovieList_Protocol?, with movie: MovieDetail) {
        DispatchQueue.main.sync {
            if let movieDetail_ViewControlLer = MovieDetail_Router.createModule(with: movie) {
                
                let viewController = view as! MovieList_ViewController
                viewController.navigationController?.pushViewController(movieDetail_ViewControlLer, animated: true)
            }
        }
        
    }
    
}
