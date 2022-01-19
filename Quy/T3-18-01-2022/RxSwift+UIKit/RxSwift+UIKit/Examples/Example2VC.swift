//
//  Example2VC.swift
//  RxSwift+UIKit
//
//  Created by Mcrew-Tech on 18/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class Example2VC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let data = ["Hello", "Bonjour", "Stop", "End"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindTableView()
    }
    
    private func bindTableView() {
        let dataSource = Observable<[String]>.just(data)
        //data source binding.
        dataSource
            .bind(to: tableView.rx.items(cellIdentifier: "cell")){
                index, model, cell in
                cell.textLabel?.text = model
            }
            .disposed(by: disposeBag)
        //user interaction binding.
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext: { model in
                print("\(model) was selected")
            })
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
