//
//  Example1.swift
//  RxSwift+UIKit
//
//  Created by Mcrew-Tech on 18/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class Example1VC: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //monitoring textField input
        textField.rx.text
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                self.label.text = self.textField.text
                })
            .disposed(by: disposeBag)
        
        //checking textField input for button state
        textField.rx.text
            .map{ $0?.count ?? 0 > 5 }
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        //checking button input
        button.rx.tap
            .throttle(.seconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.clearAll()
            })
            .disposed(by: disposeBag)
        
        //checking if button is pressed inside
        button.rx
            .controlEvent(UIControl.Event.touchUpInside)
            .subscribe(onNext: { print("Button TouchUpInside") })
            .disposed(by: disposeBag)
    }
    
    private func clearAll() {
        textField.text = ""
        label.text = ""
        button.isEnabled = false
    }
}
