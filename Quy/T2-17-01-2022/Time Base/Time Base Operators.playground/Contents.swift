import Foundation
import RxSwift

//MARK: Support

public func printValue(_ string: String) {
    let d = Date()
    let df = DateFormatter()
    df.dateFormat = "ss.SSSS"
    
    print("\(string) --- at \(df.string(from: d))")
}

public extension DispatchSource {
    class func timer(interval: Double, queue: DispatchQueue, handler: @escaping ()->Void) -> DispatchSourceTimer {
        let source = DispatchSource.makeTimerSource(queue: queue)

        source.setEventHandler(handler: handler)
        source.schedule(deadline: .now(), repeating: interval, leeway: .nanoseconds(0))
        source.resume()

        return source
    }
}

let bag = DisposeBag()

//MARK: 1/ Buffering operators

// 1.1/ Basic with Timer

/**
 Need to make a new constant/variable to run this function.
 */
func basicTimer() -> Observable<Int> {
    let elementsPerSecond = 1
    let maxElement = 5
    let replayedElement = 1
    let replayDelay: TimeInterval = 3
        
    let observable = Observable<Int>.create { (observer) -> Disposable in
        
        var value = 1
        
        let source = DispatchSource.makeTimerSource(queue: .main)
        source.setEventHandler {
            if value <= maxElement {
                observer.onNext(value)
                value += 1
            } else {
                observer.onCompleted()
            }
        }
        
        source.schedule(
            deadline: .now(),
            repeating: 1.0 / Double(elementsPerSecond),
            leeway: .nanoseconds(0)
        )
        source.resume()
        
        return Disposables.create {
            source.suspend()
        }
    }
    //original observable
    DispatchQueue.main.asyncAfter(deadline: .now()) {
        observable
            .subscribe(onNext: { (value) in
                print("🔴 : \(value)")
            }, onCompleted: {
                print("🔴 Completed")
            }, onDisposed: {
                print("🔴 Disposed")
            })
            .disposed(by: bag)
    }
    
    return observable
}

//let temp = basicTimer()

// 1.2/ Replaying past elements

/**
 .relay(_:) operator create a connectable observable sequence that can replay the last elements in its buffer.
 - note: To use it you have to call .connect() on the 2nd observable.
 */
func replay() {
    let elementsPerSecond = 1
    let maxElement = 5
    let replayedElement = 2
    let replayDelay: TimeInterval = 3
        
    let observable = Observable<Int>.create { (observer) -> Disposable in
        
        var value = 1
        
        let source = DispatchSource.makeTimerSource(queue: .main)
        source.setEventHandler {
            if value <= maxElement {
                observer.onNext(value)
                value += 1
            }
        }
        
        source.schedule(
            deadline: .now(),
            repeating: 1.0 / Double(elementsPerSecond),
            leeway: .nanoseconds(0)
        )
        source.resume()
        
        return Disposables.create {
            source.suspend()
        }
    }
    //original observable
    DispatchQueue.main.asyncAfter(deadline: .now()) {
        observable
            .subscribe(onNext: { (value) in
                printValue("🔴 : \(value)")
            }, onCompleted: {
                print("🔴 Completed")
            }, onDisposed: {
                print("🔴 Disposed")
            })
            .disposed(by: bag)
    }
    /// replaying past elements
    
    let replaySource = observable.replayAll()
//    let replaySource = observable.replay(replayedElement)
    
    //replay observable
    DispatchQueue.main.asyncAfter(deadline: .now() + replayDelay) {
        replaySource
            .subscribe(onNext: { (value) in
                printValue("🔵 : \(value)")
            } ,onCompleted: {
                print("🔵 Completed")
            } ,onDisposed: {
                print("🔵 Disposed")
            })
            .disposed(by: bag)
    }

    replaySource.connect()
}

// 1.3/Controlled Buffering

/**
 - Create a buffer which is an array that contains element emitted by the observable.
 - The values in the buffer will be sent out either when the buffer is full or a certain time has passed, using a specified scheduler to run timer.
 */
func controlledBuffering() {
    let bufferTimeSpan = RxTimeInterval.milliseconds(4_000)
    let bufferMaxCount = 4
    
    let source = PublishSubject<String>()
    
    //observing the observable
    source
        .subscribe(onNext: { value in
            printValue("🔴: \(value)")
        })
        .disposed(by: bag)
    
    //observing the observable buffer
    source
        //the buffer is an array of String
        .buffer(
            timeSpan: bufferTimeSpan,
            count: bufferMaxCount,
            scheduler: MainScheduler.instance
        )
        .map { $0.count }
        .subscribe(onNext: { value in
            printValue("🔵: \(value)")
        })
        .disposed(by: bag)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
        source.onNext("A")
        source.onNext("B")
        source.onNext("C")
        source.onNext("D")
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 16) {
        source.onCompleted()
    }
    
//    let dispatchSource = DispatchSource.makeTimerSource(queue: .main)
//    dispatchSource.setEventHandler {
//        source.onNext("X")
//    }
//    dispatchSource.schedule(deadline: .now(), repeating: 1.0, leeway: .nanoseconds(0))
//    dispatchSource.resume()
}

// 1.4/ Window

/**
 Like buffer which stores element but as an observable.
 */
func window() {
    let bufferTimeSpan = RxTimeInterval.milliseconds(4_000)
    let bufferMaxCount = 2
    
    let source = PublishSubject<String>()
    
    //observing the observable
    source
        .subscribe(onNext: { value in
            printValue("🔴: \(value)")
        }).disposed(by: bag)
    
    //observing the observables buffer
    source
        //the buffer is now an observable sequence of [String]
        .window(timeSpan: bufferTimeSpan, count: bufferMaxCount, scheduler: MainScheduler.instance)
        //turning the buffer into an array of string
        .flatMap { (observable) -> Observable<[String]> in
            observable
                .scan(into: []) { (array, element) in
                    array.append(element)
                }
        }
        .subscribe(onNext: { (value) in
            printValue("🔵: \(value)")
        })
        .disposed(by: bag)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
        source.onNext("1")
        source.onNext("2")
        source.onNext("3")
        source.onNext("4")
        source.onNext("5")
    }
}

window()

//MARK: 2/ Time shifting operator

/**
 delay when the subscription happen. Element emitted before the delay is ignored
 */
func delayedSubscription() -> DispatchSourceTimer {
    let source = PublishSubject<String>()
    
    source
        .delaySubscription(.seconds(2), scheduler: MainScheduler.instance)
        .subscribe(onNext: { value in
            printValue("🔴: \(value)")
        })
        .disposed(by: bag)

    var count = 1
    let temp = DispatchSource.timer(interval: 1.0, queue: .main) {
        source.onNext("\(count)")
        count += 1
    }
    
    return temp
}

//let timerSubscription = delayedSubscription()

// 2.2/ Delayed elements

/**
 delay the time when an observable sequence is returned.
 
 - note: an error event is not delayed.
 */
func delayElement() -> DispatchSourceTimer {
    let source = PublishSubject<String>()
    source
        .delay(.seconds(2), scheduler: MainScheduler.instance)
        .subscribe(onNext: { value in
            printValue("🔴: \(value)")
        })
        .disposed(by: bag)
    
    var count = 1
    var temp = DispatchSource.timer(interval: 1, queue: .main) {
        printValue("emit: \(count)")
        source.onNext("\(count)")
        count += 1
    }
    
    return temp
}

//let a = delayElement()

//MARK: 3/Timer Operator

// 3.1/ interval

/**
 Tell the observable to emit an element after each certain period
 */
func interval() {
    let source = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
    let replay = source.replay(2)
    
    DispatchQueue.main.asyncAfter(deadline: .now()) {
        source
            .subscribe(onNext: { value in
                printValue("🔴: \(value)")
            }, onCompleted: {
                print("🔴 Completed")
            }, onDisposed: {
                print("🔴 Disposed")
            })
            .disposed(by: bag)
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
        replay
            .subscribe(onNext: { value in
                printValue("🔵: \(value)")
            }, onCompleted: {
                print("🔵 Completed")
            }, onDisposed: {
                print("🔵 Disposed")
            })
            .disposed(by: bag)
    }
    
    replay.connect()
}

// 3.2/ Timer

/**
 Tell the observable to emit an element after a certain time, then terminated it self when done.
 */
func timer() {
    let source = Observable<Int>.timer(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
    
    DispatchQueue.main.asyncAfter(deadline: .now()) {
        source
            //delay by 2 more second.
//            .flatMap{ _ in
//                source.delay(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
//            }
            .subscribe(onNext: { value in
                printValue("🔴: \(value)")
            }, onCompleted: {
                print("🔴 Completed")
            }, onDisposed: {
                print("🔴 Disposed")
            })
            .disposed(by: bag)
    }
}

// 3.3/ Timeout

/**
 Send an error to an observer if the next element doesn't emit within a certain time when the observable last emitted.
 - note: the error is TimeOutError
 */
func timeout() {
    let source = PublishSubject<Int>()
    source
        .timeout(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance)
        .subscribe(onNext: { value in
            printValue("🔴: \(value)")
        }, onCompleted: {
            print("🔴 Completed")
        }, onDisposed: {
            print("🔴 Disposed")
        })
        .disposed(by: bag)

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        source.onNext(1)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        source.onNext(2)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        source.onNext(3)
    }
}

/*
 Summary:
    +replay(_:) : replay all elements in a buffer with the size limit as the parameter.
    +replayAll() : like .replay(_:) but has no buffer size limit.
    +buffer(): customizable buffer with multiple paramaters: time, size & threads.
    +window(): work like buffer but instead of an array it turn buffer into an observable
    +delaySubscription: delay the subscribing by an specific amount.
    +delay: delay the time the value returned.
    +interval: creating a for loop which emit element when an period has passed.
    +timer: like interval but only emit once.
    +timeout: end an observable whenever a certain time has passed and the observable haven't emmitted anything.
 */
