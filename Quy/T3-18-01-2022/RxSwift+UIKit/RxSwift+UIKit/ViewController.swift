//
//  ViewController.swift
//  RxSwift+UIKit
//
//  Created by Mcrew-Tech on 18/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

class ViewController: UIViewController {
    
    @IBOutlet weak var segueBtn1: UIButton!
    @IBOutlet weak var segueBtn2: UIButton!
    @IBOutlet weak var segueBtn3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        segueBtn1.rx.tap
            .subscribe(onNext: { [weak self] value in
                guard let strongSelf = self else { return }
                strongSelf.performSegue(withIdentifier: "goToExample1VC", sender: strongSelf)
            })
            .disposed(by: disposeBag)
        
        segueBtn2.rx.tap
            .subscribe(onNext: { [weak self] value in
                guard let strongSelf = self else { return }
                strongSelf.performSegue(withIdentifier: "goToExample2VC", sender: strongSelf)
            })
            .disposed(by: disposeBag)
        
        segueBtn3.rx.tap
            .subscribe(onNext: { [weak self] value in
                guard let strongSelf = self else { return }
                strongSelf.performSegue(withIdentifier: "goToExample3VC", sender: strongSelf)
            })
            .disposed(by: disposeBag)
    }
}


