//
//  MovieList_Presenter.swift
//  ViperMovie
//
//  Created by Hao Lam on 1/20/22.
//

import UIKit


///** NOTE: We are splitting Presenter into 2 parts:
///
///** 1. View --> Presenter
///
class MovieList_Presenter : ViewToPresenter_MovieList_Protocol {

    var movies = [Movie]()
    
    var view: PresenterToView_MovieList_Protocol?

    var interactor: PresenterToInteractor_MovieList_Protocol?

    var router: PresenterToRouter_MovieList_Protocol?

    func viewDidLoad() {
        view?.showActivity()
        //Presenter is asking Interactor to load new data
        interactor?.fetchMovieList() // business logic should be written inside interactor
    }

    func refresh() {
        //implement as per usgae. Ideally It should be responsible for refreshing api data
        // we can:  call interactor?.fetchMovieList() again
        // or write another function separately for resfeshing data
    }

    func numberOfRowsInSection() -> Int {
        return movies.count
    }

    func setCell(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = movies[indexPath.row].title
            return cell
            
    }

    func didSelectRowAt(index: Int) {
        interactor?.getMovieDetail(index: movies[index].id)
    }

}

///** 2. Interactor --> Presenter
///
///
extension MovieList_Presenter : InteractorToPresenter_MovieList_Protocol{
    func fetch_MovieList_sucess(movies: [Movie]) {
        self.movies = movies
        view?.hideActiviy()
        view?.onFetch_MovieList_Success()
    }
    
    func fetch_MovieList_fail(error: String) {
        view?.hideActiviy()
        view?.onFetch_MovieList_Failure(error: "Fail to fetch movie")
    }
    
    
    
    func get_MovieDetail_sucess(_ detail: MovieDetail) {
        // MovieDetail's interactor notice MovieList's interactor that getting movie detail is successful
        // => MovieList's interactor communicate with MovieList's presenter about that
        // => From that, go to Movie Detail screen
        print("Got comment")
        print(detail)
        router?.pushToMovieDetail(on: view, with: detail)
    }

    
    func get_MovieDetail_fail() {
        view?.hideActiviy()
        //show alert here
        print("Movie detail failure")
    }

 
    
    
}
