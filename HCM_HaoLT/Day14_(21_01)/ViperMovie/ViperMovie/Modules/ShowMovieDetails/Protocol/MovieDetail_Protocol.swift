//
//  MovieDetail_Protocol.swift
//  ViperMovie
//
//  Created by Hao Lam on 1/21/22.
//

import Foundation
import UIKit

///** View Input : (View  -->  Presenter)
protocol ViewToPresenter_MovieDetail_Protocol {
// View-Related Logic are written in Presenter only
    //Managing comunication from View to Presenter layer
    
    //properties
    var view : PresenterToView_MovieDetail_Protocol? { get set }
    var interactor : PresenterToInteractor_MovieDetail_Protocol? { get set }
    var router : PresenterToRouter_MovieDetail_Protocol? {get set}
    
    
    // 2 functions comming from view controller
    func viewDidLoad()
    // download poster image
    func populateDataIn(imgViewMovie: UIImageView, lblDetail: UILabel)

}

///** View Output : (Presenter  -->  View)
protocol PresenterToView_MovieDetail_Protocol : AnyObject {
    //whenever user take action on View layer
    //=> View inform Presenter, and according to that we need to fetch some data
    //=> Presenter interact with Interactor to call api or get data from database
    //=> And once fetching data is completed, Presenter inform back to View either sucess or fail,
    //  and from that decide to hide or show activity
    
    func onGetImageFromURL_Success()
    func onGetImageFromURL_Failure(error : String)
    func showActivity()
    func hideActivity()
    
}

///** Interactor Input : (Presenter  -->  Interactor)
protocol PresenterToInteractor_MovieDetail_Protocol {
    
    //holding movie detail coming from interactor
    var movieDetail: MovieDetail? {get set}
    
    var presenter : InteractorToPresenter_MovieDetail_Protocol? {get set}

    func getImageData()
    
}

///** Interactor Output : (interactor  -->  Presenter)
protocol InteractorToPresenter_MovieDetail_Protocol {
    //All the functions that will establish the communication from Interactor to Presenter
    //that will inform Presenter layer whether data has been fetched sucessfully or fail
    func getImageFromURL_Success(moviesDetail : MovieDetail?, image: UIImage)
    func getImageFromURL_Failure(error: String)
    
}

///** Router Input : (Presenter  -->  Router)

protocol PresenterToRouter_MovieDetail_Protocol {
    
    static func createModule(with movie: MovieDetail) -> UIViewController?
    
}

