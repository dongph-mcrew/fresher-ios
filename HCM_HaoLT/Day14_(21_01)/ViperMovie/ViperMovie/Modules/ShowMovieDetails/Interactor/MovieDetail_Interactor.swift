//
//  MovieDetail_Interactor.swift
//  ViperMovie
//
//  Created by Hao Lam on 1/21/22.
//

import Foundation
import UIKit

class MovieDetail_Interactor : PresenterToInteractor_MovieDetail_Protocol {
    var movieDetail: MovieDetail?
    
    var presenter: InteractorToPresenter_MovieDetail_Protocol?
    
    func getImageData() {
        //call api to download image from Repository
        // according to sucess and failure in repo layer, inform presenter
        // imageURL will come from -> movieDetail?.synopsis?.posterPath
        
        let imageObjectFromApi = UIImage(systemName: "heart.text.square")
        presenter?.getImageFromURL_Success(moviesDetail: movieDetail, image: imageObjectFromApi!)
        
        // or
        // presenter?.getImageFromURLFailure(error: error)
    }
    
    
}
