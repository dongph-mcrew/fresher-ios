import UIKit
import RxSwift


//*************************** ADDS-ON FUNC *************************** //
// A function to print value with time
public func printValue(_ string: String) {
    let d = Date()
    let df = DateFormatter()
    df.dateFormat = "ss.SSSS"
    
    print("\(string) --- at \(df.string(from: d))")
}
// A function to create DispatchSouce Timer

public extension DispatchSource {
    class func timer (interval: Double, queue: DispatchQueue, handler: @escaping () -> Void) -> DispatchSourceTimer {
        let source = DispatchSource.makeTimerSource(queue : queue)
        source.setEventHandler(handler: handler)
        source.schedule(deadline: .now(), repeating: interval, leeway: .nanoseconds(0))
        source.resume()
        return source
        
    }
}
//*************************** START HERE *************************** //

let disposeBag = DisposeBag()

// Basic with Timer

print()
print(">>>>>Basic Timer Example: ")
print()

// To emits elements by specific time

let elementsPerSecond = 1
let maxElements = 15
let replayedElements = 1
let replayDelay: TimeInterval = 3

// 1. Create an observable that emits elements at a frequency of elementsPerSecond.
// - Also, cap the total number of elements emitted, and control how many elements are “played back” to new subscribers.
let source = Observable<Int>.create { observer in
    var value = 1
    /// create a timer on main queue
    let source = DispatchSource.makeTimerSource(queue: .main)

    /// handle event after repeated time elapse
    source.setEventHandler {
       if value <= maxElements {
           observer.onNext(value)
           value += 1
       }
    }
    /// schedule event
    source.schedule(deadline: .now(), repeating: 1.0 / Double(elementsPerSecond), leeway: .nanoseconds(0))

    /// start source
    source.resume()

    ///stop source in Disposables.create()
    return Disposables.create {
              source.suspend()
          }
}
/// make a subscription in main thread
DispatchQueue.main.async {
        ///emitted values will show up one by one
        source
            .subscribe(onNext: { value in
                printValue("🔴 : \(value)")
            }, onCompleted: {
                print("🔴 Completed")
            }, onDisposed: {
                print("🔴 Disposed")
            })
            .disposed(by: disposeBag)
    }


//>>>>>>>>>>>>>>>>>>>> Replaying past elements

/*
 replay()
 */
print()
print(">>>>>Replaying past elements Example: ")
print()

let source1 = Observable<Int>.create { observer in
    var value = 1
    /// create a timer on main queue
    let source = DispatchSource.makeTimerSource(queue: .main)

    /// handle event after repeated time elapse
    source.setEventHandler {
       if value <= maxElements {
           observer.onNext(value)
           value += 1
       }
    }
    /// schedule event
    source.schedule(deadline: .now(), repeating: 1.0 / Double(elementsPerSecond), leeway: .nanoseconds(0))

    /// start source
    source.resume()

    ///stop source in Disposables.create()
    return Disposables.create {
              source.suspend()
          }
}

// Create a Observable Replay
let replaySource = source1.replay(1) /// number of buffer element to replay it to subscriber

//Start subscribe after 3 seconds delay
DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    replaySource
        .subscribe(onNext: { value in
            printValue("🔵 : \(value)")
        }, onCompleted: {
            print("🔵 Completed")
        }, onDisposed: {
            print("🔵 Disposed")
        })
        .disposed(by: disposeBag)
}
///** NOTE: because it belongs to ConnectableObservable, therefore, to execute, we must connect it to observable by calling .connect()
replaySource.connect()

/*
 replayAll()
 */
let replaySource2 = source1.replayAll()
DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    replaySource2
        .subscribe(onNext: { value in
            printValue("🟠 : \(value)")
        }, onCompleted: {
            print("🟠 Completed")
        }, onDisposed: {
            print("🟠 Disposed")
        })
        .disposed(by: disposeBag)
}
replaySource2.connect()

/*
>>>>>>>>>>>>>>>>>>>> Controlled buffering
 */

print()
print(">>>>>Controlled buffering Example: ")
print()

let bufferTimeSpan = RxTimeInterval.milliseconds(4000) // 4 seconds time span
let bufferMaxCount = 2

let source2 = PublishSubject<String>()

source2
    //1. manage buffering
    //  + timeSpan : buffering spanning time
    //  + count : maximum number of elements that a buffer can store
    //  + scheduler : select which thread to execute
    .buffer(timeSpan: bufferTimeSpan, count: bufferMaxCount, scheduler: MainScheduler.instance)
    //2. AFTER timespan it will emits an event (independent with source2), so need to be modify a bit to read current number elements in the buffer
    .map{ $0.count }
    .subscribe(onNext: { (value) in
        printValue("🟤 : \(value)")

    })
    .disposed(by: disposeBag)

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    source2.onNext("A")
    source2.onNext("B")
    source2.onNext("C")
    source2.onNext("D")
    source2.onNext("E")
}


let dispatchSource = DispatchSource.makeTimerSource(queue: .main)
dispatchSource.setEventHandler {
    source2.onNext("X")
}

dispatchSource.schedule(deadline: .now(), repeating: 1.0, leeway: .nanoseconds(0))
dispatchSource.resume()


/*
    window:
    + similar to buffer
    + the only difference is that the data type is an Observable, not an Array like in buffer

 */

print()
print(">>>>>Window Example: ")
print()

source2
    //source.window : Observable<String>
    .window(timeSpan: bufferTimeSpan, count: bufferMaxCount, scheduler: MainScheduler.instance)
    //convert Observable<String> to Array String with flat map
    .flatMap({ obs -> Observable<[String]> in
        // because it's an Observable, we scan all its emitted element into 1 single value
        obs.scan(into: []) { $0.append($1) }
    })
    .subscribe(onNext: { (value) in
        printValue("👻 \(value)")
    })
    .disposed(by: disposeBag)

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    source2.onNext("1")
    source2.onNext("2")
    source2.onNext("3")
    source2.onNext("4")
    source2.onNext("5")
    source2.onNext("6")
    source2.onNext("7")
}


// Time-shifting operators
/*
    Delayed subscription: delaying register a subscription to certain amount of time.
    + Of course, any emitted element before the subscription will not be recieved
 */
print()
print(">>>>>Delayed subscription Example: ")
print()

let source3 = PublishSubject<String>()

source3
    // delay scubcription for 2 second at start
    .delaySubscription(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
    .subscribe(onNext: { value in
        printValue("🤡 : \(value)")
    })
    .disposed(by: disposeBag)

var count = 1
// for every 1s, emit event once.
/// **NOTE:
///  + the 1st element we recieved is 3
///  + if we don't do : timer.suspend(), it will never end
var timer = DispatchSource.timer(interval: 1.0, queue: .main) {
    source3.onNext("\(count)")
    count += 1
}

/*
 Delayed elements: delay recieving elements

 */

print()
print(">>>>>Delayed elements Example: ")
print()

let source4 = PublishSubject<String>()

source4
    // delay elements for 2 second
    .delay(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
    .subscribe(onNext: { value in
        printValue("🤖 recieve: \(value)")
    })
    .disposed(by: disposeBag)

var count4 = 1
var timer4 = DispatchSource.timer(interval: 1.0, queue: .main) {
    printValue("emit: \(count4)")
    source4.onNext("\(count4)")
    count4 += 1
}

// Time operator
/*
//    interval(_:scheduler:)
// */
// for every 1s, emits 1 element
let source5 = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
let replay5 = source5.replay(2)

DispatchQueue.main.asyncAfter(deadline: .now()) {
    source5
        .subscribe(
           onNext: { value in
            printValue("👺 : \(value)")
        }, onCompleted: {
            print("👺 Completed")
        }, onDisposed: {
            print("👺 Disposed")
        })
        .disposed(by: disposeBag)

}
replay5.connect()


/*
//    timer:
//    + similar to interval
//    + set a timer, and when time comes, emit the value
// */
//
let source6 = Observable<Int>.timer(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)

/// **NOTE: it only emits 1 element then terminate**
source6
    /// **To make it emits more than 1, we use flatMap()**
    /// Here in flatMap(), we continue delaying for 2s more before subscriber can recieve events
    .flatMap({ _ in
        source6.delay(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
    })
    .subscribe { value in
        printValue("👽 : \(value)")
    } onError: { error in
        printValue("👽 error")
    } onCompleted: {
        printValue("👽 completed")

    } onDisposed: {
        printValue("👽 disposed")
    }
    .disposed(by: disposeBag)

/*
    timeout:
    + Similar to request API, if there are no emits left, it will automatically terminate
 */

let source7 = PublishSubject<Int>()

source7
    /// ** time set for 5s. After 5s, terminate if doesn't recieve anymore emits**
    .timeout(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance)
    .subscribe { value in
        printValue("🐶 : \(value)")
    } onError: { error in
        printValue("🐶 error")
    } onCompleted: {
        printValue("🐶 completed")

    } onDisposed: {
        printValue("🐶 disposed")
    }
    .disposed(by: disposeBag)

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    source7.onNext(1)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    source7.onNext(2)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
    source7.onNext(3)
}

///**NOTE: this exceed 5s rule, "4" emits after 6s, therefore, subscriber won't recieve this as source has already terminated**
DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
    source7.onNext(4)
}
