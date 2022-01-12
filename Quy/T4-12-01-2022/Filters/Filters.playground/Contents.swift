import RxSwift
import Foundation
import Darwin

///Filtering operators

//ignoring operators
let subject = PublishSubject<String>()
let bag = DisposeBag()
    //ignore elements
func ignoreElements() {
    subject.ignoreElements().subscribe { event in
        print(event)
    }
    
    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")
    subject.onCompleted()
    ///only run at on completed.
}

    //element at
func elementAt() {
    subject.element(at: 2).subscribe { event in
        print(event)
    }.disposed(by: bag)
    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")
    subject.onCompleted()
    ///only take the element at 2 in the sequence & end the subscription
}

    //filter
func filter() {
    let array = Array(0...10)
    Observable
        .from(array)
        .filter { $0 % 2 == 0 }
        .subscribe { print($0) }
        .disposed(by: bag)
}

///skip operator
    //skip
func skip() {
    Observable.of("A","B","C","D","E","F")
        .skip(3).subscribe{ print($0) }.disposed(by: bag)
}
    //skipWhile
func skipWhile() {
    Observable.of(2, 4, 8, 9, 2, 4, 5, 7, 0, 10)
        .skip{ $0 % 2 == 0 }
        .subscribe{ print($0) }
        .disposed(by: bag)
        ///only filter while the condition satisfy. When it isn't it will stop filtering.
}

    //skipUntil
func skipUntil() {
    let trigger = PublishSubject<String>()
    
    subject
        .skip(until: trigger)
        .subscribe{ print($0) }
        .disposed(by: bag)
    
    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")
    subject.onNext("4")
    subject.onNext("5")
    trigger.onNext("XXX")
    subject.onNext("6")
    subject.onNext("7")
}

///Taking operator
//take
func take() {
    Observable.of( 1, 2, 3, 4, 5, 6, 7, 8, 9)
        .take(4)
        .subscribe{ print($0) }
        .disposed(by: bag)
    ///only take 4 value
}

//takeWhile
func takeWhile() {
    Observable.of( 1, 2, 3, 4, 5, 6, 7, 8, 9)
        .take(while: { $0 < 4 })
        .subscribe{ print($0) }
        .disposed(by: bag)
}
    //enumerated
func enumerated() {
    Observable.of(2, 4, 6, 8, 0, 12, 1, 3, 4, 6, 2)
        .enumerated() //return a tuple of (value, index)
        .take(while: { (value,index) in
            value % 2 == 0 && index < 3
        })
        .subscribe{ print($0) }
        .disposed(by: bag)
        //Make the stream into an enumerated array.
}

    //takeUntil
func takeUntil() {
    let trigger = PublishSubject<String>()
    
    subject.take(until: trigger)
        .subscribe{ print($0) }.disposed(by: bag)
    
    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")
    subject.onNext("4")
    subject.onNext("5")
    trigger.onNext("XXX")
    subject.onNext("6") //call onward gets ignored.
    subject.onNext("7")
}

///distinct operators

//equatable type
func equatableType() {
    Observable.of("A", "A", "B", "B", "A", "A", "A", "C", "A")
        .distinctUntilChanged()
        .subscribe{ print($0) }
        .disposed(by: bag)
    ///removing duplicate of the value being emitted.
}

//custom type
func customType() {
    struct Point {
        var x: Int
        var y: Int
    }
    
    let array = [
    Point(x: 0, y: 1),
    Point(x: 0, y: 2),
    Point(x: 1, y: 0),
    Point(x: 1, y: 1),
    Point(x: 1, y: 3),
    Point(x: 2, y: 1),
    Point(x: 2, y: 2),
    Point(x: 0, y: 0),
    Point(x: 3, y: 3),
    Point(x: 0, y: 1)
    ]
    
    Observable.from(array)
        .distinctUntilChanged{ (p1, p2)->Bool in
            p1.x == p2.x
        }
        .subscribe{ point in
            if let point = point.element {
                print("Point \(point.x):\(point.y)")
            }
        }
        .disposed(by: bag)
}

/* Summary:
 +ignoreElements(): only accept .completed & .error.
 +element(at:_): similar to subscript.
 +filter { }: filter all the elements in a sequence until the Observable finished emitting.
 +skip: ignore n elements.
 +skip(while:_): only skip the element satisfying the requirement. Stop skipping once satisfied
 +skip(until:_): only skip the element if the observable used as requirement hasn't emit. Also stop skipping once satisfied.
 +take(_:): only take an n amount of elements. Once exceeded ingore all the elements onward.
 +take(while:_): only take the element fit the requirement. Once unsatisfied will ignore all the elements onward.
 +take(until:_): reverse of skip until where it will only take until the observable used as requirement start emitting. Once unsatisfied will ignore all the elements onward.
 +distinctUntilChanged(): remove all item with the same value. work with equatable conformed type & custom type.
 +enumerated() : similar to .enumerated() for Collection types where it will make the observable emit a tuple contain index & value.
 */



