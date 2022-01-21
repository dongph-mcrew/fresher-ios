//
//  MovieDetail_Presenter.swift
//  ViperMovie
//
//  Created by Hao Lam on 1/21/22.
//

import Foundation
import UIKit


class MovieDetail_Presenter : ViewToPresenter_MovieDetail_Protocol {
    
    var movieDetail: MovieDetail?
    
    var imgMovie: UIImage?
    
    var view: PresenterToView_MovieDetail_Protocol?
    
    var interactor: PresenterToInteractor_MovieDetail_Protocol?
    
    var router: PresenterToRouter_MovieDetail_Protocol?
    
    func viewDidLoad() {
        view?.showActivity()
        interactor?.getImageData()
    }
    
    func populateDataIn(imgViewMovie: UIImageView, lblDetail: UILabel) {
        print("Populate comment to screen")
        lblDetail.text = movieDetail?.body ?? "N/A"
        imgViewMovie.image = imgMovie
    }
    
    
}

extension MovieDetail_Presenter : InteractorToPresenter_MovieDetail_Protocol {
    func getImageFromURL_Success(moviesDetail: MovieDetail?, image: UIImage) {
        view?.hideActivity()
        imgMovie = image
        self.movieDetail = moviesDetail
        view?.onGetImageFromURL_Success()
        
    }
    
    func getImageFromURL_Failure(error: String) {
        print(error)
        view?.hideActivity()
        view?.onGetImageFromURL_Failure(error: error)
    }
    
    
}
