import Foundation
import RxSwift

func publishSubject() {
    //making a subject.
    let subject = PublishSubject<String>()
    //emitting a value.
    subject.onNext("Hello World")
    //subscribing to the subject.
    let subscription1 = subject.subscribe { (value) in
        print(value)
    }
    //emitting again this time with a subscriber.
    subject.onNext("Hello again")
    subject.onNext("Hello again thrice")
    subject.onNext("Bye")
}

func behaviourStream() {
    let behaviourStream = BehaviorSubject<Int>(value: 0)
    let sub1 = behaviourStream.subscribe { (value) in
        print(value)
    }
    behaviourStream.onNext(2)
    let sub2 = behaviourStream.subscribe { (value) in
        print("new sub: \(value)") ///Only print 2 because it's the last value.
    }
}

func replayStream() {
    let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
    replaySubject.onNext("First")
    replaySubject.subscribe{
        if let safeValue = $0.element {
            print("1: \(safeValue)")
        }
    }
    replaySubject.onNext("Second")
    replaySubject.subscribe {
        if let new = $0.element {
            print("2: \(new)")
        }
    }
    replaySubject.onNext("Third")
    replaySubject.subscribe {
        if let new = $0.element {
            print("3: \(new)")
        }
    }
}


