//
//  ViewController.swift
//  Time Base
//
//  Created by Mcrew-Tech on 17/01/2022.
//

import UIKit
import RxSwift

public extension DispatchSource {
    class func timer(interval: Double, queue: DispatchQueue, handler: @escaping () ->Void) -> DispatchSourceTimer {
        let source = DispatchSource.makeTimerSource(queue: queue)

        source.setEventHandler(handler: handler)
        source.schedule(deadline: .now(), repeating: interval, leeway: .nanoseconds(0))
        source.resume()

        return source
    }
}


class ViewController: UIViewController {

    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.\
        let source = PublishSubject<String>()
        print("start")
        source
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: { value in
                print("Red: \(value)")
            })
            .disposed(by: bag)
        print("start 2")
        var count = 1
        var a = DispatchSource.timer(interval: 1, queue: .main) {
            print("emit: \(count)")
            source.onNext("\(count)")
            count += 1
        }
    }

    func delayElement() {
    }

}

