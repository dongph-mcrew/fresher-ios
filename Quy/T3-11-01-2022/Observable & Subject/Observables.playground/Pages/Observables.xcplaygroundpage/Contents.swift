import Foundation
import RxSwift

let ios = 1
let android = 2
let flutter = 3

// 3/ Creating Observables

    //just (single element)
let observable1 = Observable<Int>.just(ios)
    //of (multiple element)
let observable2 = Observable.of(ios, android, flutter)

let observable3 = Observable.of([ios, android, flutter])
    //from (array of element)
let dev = [ios, android, flutter]
let observable4 = Observable.from(dev)

// 4/ Subscribing to observables

    //add Observer
///the code here show how an observable fire off all of it value.
func addObserver() {
    let sequence = 0..<3
    var iterator = sequence.makeIterator()
    while let n = iterator.next() {
        print(n)
    }
}

    //subscribe
    ///subscribe is used to listen to an observable.
func subscribe() {
    observable1.subscribe { event in ///The function act as an observer.
        print(event)
    }
    
    observable2.subscribe { event in
        if let element = event.element {
            print(element)
        }
    }
}

    //handle event
/* Note:
 Event that Observable can provide:
    +onNext: Closure for when event emit each element of an observable sequence.
    +onError: Closure for when event emit error & the observable sequence is terminated
    +onCompleted: Closure for when the event emit observable sequence finished emitting and then terminating the observable.
    +onDisposed: Closure for when the event emit the sequence is terminated.
}
*/
func handleEvent() {
    //onNext
    observable3.subscribe(onNext: { element in
        print(element)
    })
    //full version
    ///subscribe can use trailing closure for all of the parameter.
    observable4.subscribe { value in
        print(value)
    } onError: { (error) in
        print(error.localizedDescription)
    } onCompleted: {
        print("Completed")
    } onDisposed: {
        print("Disposed")
    }
    //remove onError & onDisposed.
    observable4.subscribe { (value) in
        print(value)
    } onCompleted: {
        print("Completed")
    }

}

// 5/ Special Observable types
func specialTypes() {
    //Empty type
    ///Empty emit any value & terminate immediately
    let observable = Observable<Void>.empty()
    observable.subscribe { (value) in
        print(value)
    } onCompleted: {
        print("Completed")
    }
    //Never type
    ///Never doesn't emit any value & never terminate.
    let observableNever = Observable<Any>.never()
    observableNever.subscribe { (element) in
        print(element)
    } onCompleted: {
        print("Completed")
    }
    //Range
    ///Basic loop through a range of Int
    let observableRange = Observable<Int>.range(start: 1, count: 10)
    var sum = 0
    observableRange.subscribe { i in
        sum += i
    } onCompleted: {
        print("Sum = \(sum)")
    }
}


