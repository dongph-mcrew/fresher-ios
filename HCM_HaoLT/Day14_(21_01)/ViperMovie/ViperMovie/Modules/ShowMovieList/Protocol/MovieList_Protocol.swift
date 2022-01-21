//
//  MovieList_Protocol.swift
//  ViperMovie
//
//  Created by Hao Lam on 1/20/22.
//

import Foundation
import UIKit

///** View Input : (View  -->  Presenter)
protocol ViewToPresenter_MovieList_Protocol {
// View-Related Logic are written in Presenter only
    //Managing comunication from View to Presenter layer
    
    //properties
    var view : PresenterToView_MovieList_Protocol? { get set }
    var interactor : PresenterToInteractor_MovieList_Protocol? { get set }
    var router : PresenterToRouter_MovieList_Protocol? {get set}
    
    
    // 2 functions comming from view controller
    func viewDidLoad()
    func refresh()
    
    
    //for table list view handling (methods coresponding for delegate of tableview)
    func numberOfRowsInSection() -> Int
    func setCell(tableView : UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell
    func didSelectRowAt(index: Int)
}

///** View Output : (Presenter  -->  View)
protocol PresenterToView_MovieList_Protocol : AnyObject {
    //whenever user take action on View layer
    //=> View inform Presenter, and according to that we need to fetch some data
    //=> Presenter interact with Interactor to call api or get data from database
    //=> And once fetching data is completed, Presenter inform back to View either sucess or fail,
    //  and from that decide to hide or show activity
    
    func onFetch_MovieList_Success() //indicate fetching data is sucessful
    func onFetch_MovieList_Failure(error: String)  //indicate fetching data is fail
    func showActivity()
    func hideActiviy()
    
}

///** Interactor Input : (Presenter  -->  Interactor)
protocol PresenterToInteractor_MovieList_Protocol {
    
    var presenter : InteractorToPresenter_MovieList_Protocol? {get set}
    
    //holding movie data coming from interactor
    var movie: [Movie]? {get set}
    
    // Below are commands that Presenter will ASK interactor
    // whenever user take any action, or you need to take any logical decision from Presenter to Interactor
    func fetchMovieList()
    
    //get movie details if user tapped on any movie from list
    func getMovieDetail(index : Int)
}

///** Interactor Output : (interactor  -->  Presenter)
protocol InteractorToPresenter_MovieList_Protocol {
    //All the functions that will establish the communication from Interactor to Presenter
    //that will inform Presenter layer whether data has been fetched sucessfully or fail
    func fetch_MovieList_sucess(movies: [Movie])
    func fetch_MovieList_fail(error: String)
    
    //Movie Details:
    
    func get_MovieDetail_sucess(_ detail: MovieDetail)
    func get_MovieDetail_fail ()
}




///** Router Input : (Presenter  -->  Router)

protocol PresenterToRouter_MovieList_Protocol {
    //
    
    static func createModule() ->UINavigationController?
    
    //pushing the Show Detail Movie Screen whenever user tapped on movie from list
    func pushToMovieDetail(on view: PresenterToView_MovieList_Protocol?, with movie: MovieDetail)
}
