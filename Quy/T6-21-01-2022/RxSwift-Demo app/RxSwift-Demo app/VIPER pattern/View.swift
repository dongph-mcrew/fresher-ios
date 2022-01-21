//
//  ViewController.swift
//  RxSwift-Demo app
//
//  Created by Mcrew-Tech on 21/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

//Obj
//protocol
//ref to Presenter

let disposeBag = DisposeBag()

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(error: Error)
    func update(success users: [User])
}

class ViewController: UIViewController, AnyView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segueBtn: UIButton!

    var presenter: AnyPresenter?
    var dataSource = PublishSubject<[User]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Router.build(with: self)
        bindUIElement()
        
        presenter?.viewDidLoad()
    }

//Binding UIs to Observable sequence
    func bindTableView() {
        dataSource
            .bind(to: tableView.rx.items(cellIdentifier: "cell")){ index,model,cell in
                cell.textLabel?.text = model.name
            }
            .disposed(by: disposeBag)
    }
    
    func bindSegueBtn() {
        segueBtn.rx.tap
            .bind{ [weak self] in
                guard let self = self else { return }
                self.segueBtnPushed()
            }
            .disposed(by: disposeBag)
    }
    
    func bindUIElement() {
        bindTableView()
        bindSegueBtn()
    }
    
    func segueBtnPushed() {
        print("Pushed Segue Button")
        presenter?.showNextScreen()
    }
    
// updating after getting from presenter
    func update(error: Error) {
        print("Error")
    }
    
    func update(success users: [User]) {
        dataSource.onNext(users)
    }
    
    deinit {
        print("View deinit")
    }
}
