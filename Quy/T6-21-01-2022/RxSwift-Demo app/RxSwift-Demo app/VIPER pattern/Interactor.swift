
import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUserList()
}

class Interactor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUserList() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        else {
            presenter?.interactorDidFetchUser(with: .failure(.failed))
            return
        }

        let session = URLSession.shared.dataTask(with: url) {
            [weak self] data, _, error in
            guard let safeData = data, error == nil else {
                self?.presenter?
                    .interactorDidFetchUser(with: .failure(.failed))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self,
                                                     from: safeData)
                self?.presenter?
                    .interactorDidFetchUser(with: .success(users))
            } catch {
                self?.presenter?
                    .interactorDidFetchUser(with: .failure(FetchError.failed))
            }
        }
        
        session.resume()
    }
}
