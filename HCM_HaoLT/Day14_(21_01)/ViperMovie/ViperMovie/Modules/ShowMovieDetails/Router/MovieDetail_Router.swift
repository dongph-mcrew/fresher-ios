//
//  MovieDetail_Router.swift
//  ViperMovie
//
//  Created by Hao Lam on 1/21/22.
//

import Foundation
import UIKit

class MovieDetail_Router : PresenterToRouter_MovieDetail_Protocol {
    static func createModule(with movie: MovieDetail) -> UIViewController? {
        //Creating complete package with nested dependency
            // This all should come from a Factory >> DI

        ///NOTE:  use this if not connect to storyboard
//        let viewController : MovieDetail_ViewController = MovieDetail_ViewController()
        
        ///NOTE: use this if connect to storyboard
        let storyBoard : UIStoryboard = UIStoryboard(name: "MovieDetail", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetail") as! MovieDetail_ViewController
  
        
        let presenter : ViewToPresenter_MovieDetail_Protocol &
                        InteractorToPresenter_MovieDetail_Protocol = MovieDetail_Presenter()

        viewController.presenter = presenter
        viewController.presenter?.router = MovieDetail_Router()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MovieDetail_Interactor()
        viewController.presenter?.interactor?.movieDetail = movie

        ///assign presenter property of interactor object
        viewController.presenter?.interactor?.presenter = presenter

        return viewController
      
    }
    
  

}
