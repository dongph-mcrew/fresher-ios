//
//  ViewController.swift
//  Day11_ExampleApp
//
//  Created by Hao Lam on 1/18/22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel : RestaunrantsListViewModel!
    
    static func instantiate(viewModel : RestaunrantsListViewModel) -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        viewController.viewModel = viewModel
        return viewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //view.backgroundColor  = .red
        
        /** `-- Normally, we don;t use it directly here
        let service = RestaurantService()
        service.fetchRestaurants().subscribe(onNext: { restaurants in
            print(restaurants)
            
        })
        .disposed(by: disposeBag)
         */
        
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        viewModel.fetchRestaurantViewModels()
        //put on main thread
            .observe(on: MainScheduler.instance)
        //bind
            .bind(to: tableView.rx.items(cellIdentifier: "cell")){ index, viewModel, cell in
                cell.textLabel?.text = viewModel.displayText
        }
            .disposed(by: disposeBag)
    }
    

}

