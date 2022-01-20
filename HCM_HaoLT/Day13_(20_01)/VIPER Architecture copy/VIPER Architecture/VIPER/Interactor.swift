//
//  Interactor.swift
//  VIPER Architecture
//
//  Created by Hao Lam on 1/20/22.
//

import Foundation

// Object
// protcol

// - Interactor should only have a reference to presenter
// - Interactor get data or perform some interaction.
//      + When the interaction completed, it will hand the data to presenter.
//      + Then, the presenter will take care of what to do with it
// - We can also make an API call from here


protocol AnyInteractor {
    // reference to presenter
    var presenter : AnyPresenter? { get set }
    
    //interactor need some contracts in terms of what functions we can call on it:
    func getUsers()
    // no completion handler here, interactor will inform presenter once it's ready
    
}

class UserInteractor : AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
         //get api call
        print("Start fetching")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self ] data, _, error in
            
            guard let data = data , error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                //Success case:
                //decode data to our entities
                let response = try JSONDecoder().decode([User].self, from: data)
                
                self?.presenter?.interactorDidFetchUsers(with: .success(response))
            }
            catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume() //execute task
    }
    
    
}
