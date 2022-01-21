//
//  MovieList_Interactor.swift
//  ViperMovie
//
//  Created by Hao Lam on 1/20/22.
//

import Foundation
import RxSwift

class MovieList_Interactor : PresenterToInteractor_MovieList_Protocol{
    
    //for notification purpose:
    // + when data recieved from api
    let disposeBag = DisposeBag() // disposing any subscription channel
    
//    //Concept of repositiory (Come from Dependency Injection):
//    // An intermediate pattern we implemented to communicate with network
//    //   or database
//    // Simply understand this as a Home Repository layer that
//    //   perform all network communication on behalf of your home screen
//    let homeRepository : HomView_RepositoryProtocol? = HomView_Repository(networkManager: NetworkManager() )
//
//
    
    var movie: [Movie]?
    
    var presenter: InteractorToPresenter_MovieList_Protocol?
    
    func fetchMovieList() {
        print("Start fetching")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self ] data, _, error in
            
            guard let data = data , error == nil else {
                self?.presenter?.fetch_MovieList_fail(error: "Fail to get movie from API call")
                return
            }
            
            do {
                //Success case:
                //decode data to our entities
                let response = try JSONDecoder().decode([Movie].self, from: data)
                
                self?.presenter?.fetch_MovieList_sucess(movies: response)
                
            }
            catch {
                self?.presenter?.fetch_MovieList_fail(error: "Fail to get movie from API call")
            }
        }
        task.resume() //execute task
    }
    
//    func fetchMovieList() {
//        //responsible to communicate with network and fetching data
//
//        homeRepository?.fetchMovieListDataWith(page: 1)
//
//        //subscribing to movie list api response
//            //once the data recieved from api, we subcribe this to our interactor class
//        homeRepository?.movieListData.subscribe { [weak self] (response) in self?.movies = response.element?.results
//
//            if let movieList = self?.movie {
//                //busuness model should be used:
//                self?.presenter?.fetch_MovieList_sucess(movies: movieList)
//            }
//        }.disposed(by: disposeBag)
//
//        // subscribing to movie list api error response
//            // in case if any error in calling api, this subcription will call fetch_MovieList_fail() of presenter => this comunication automatically go from presenter to view
//        homeRepository?.movieListError.subscribe {
//            (response) in
//            self.presenter?.fetch_MovieList_fail(error: response.element?.stringMessage() ?? "Movie List Error")
//        }.disposed(by: disposeBag)
//    }
    
    func getMovieDetail(index: Int) {
        //call api here again just like in fetchMovieList()
        // self.presenter?.getMovieDetailFailur()
        // OR
        
        print("Start fetching Comments")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self ] data, _, error in
            
            guard let data = data , error == nil else {
                self?.presenter?.get_MovieDetail_fail()
                return
            }
            
            do {
                //Success case:
                //decode data to our entities
                let response = try JSONDecoder().decode([MovieDetail].self, from: data)
                
                
                var  movieDetail = MovieDetail(postId: index, body: "Empty")
                
                for item in response {
                    if item.postId == index {
                        movieDetail = item
                    }
                }
                
                //once sucess, do:
                self?.presenter?.get_MovieDetail_sucess(movieDetail)
                
            }
            catch {
                self?.presenter?.get_MovieDetail_fail()
            }
        }
        task.resume() //execute task
        
        
    }
    
    
}
