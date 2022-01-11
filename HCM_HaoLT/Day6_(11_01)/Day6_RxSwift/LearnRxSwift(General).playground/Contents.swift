import UIKit
import RxSwift
import RxCocoa
import Combine


// Transformation: transform emitted element by an observable sequence to a new form BEFORE subscribers recieve them

    // + (Transform) Using 'map' operator

    ///EX: multiplies each value of a sequence with 10 before emitting.
let multiplyOB = Observable.of(1,2,3,4).map { values in
    return values * 10
} .subscribe{
    print("Transform using 'map':")
    print($0)
}

    // + (Merging) Using 'FlatMap' operator:  merges the emission of these resulting Observables and emitting these merged results as its own sequence.

let ob1 = Observable.of(1,2)
let ob2 = Observable.of(3,4)

///'combineOB' = Observable Sequence that consists of objects that are themselves Observables
let mergeOB = Observable.of(ob1,ob2)

mergeOB.flatMap{ return $0 }.subscribe(onNext:{
    print("Transform using 'FlatMap':")
    print($0)
})


    // + (Combine all to 1 final result) Using 'Scan': starts with an initial seed value and is used to aggregate values just like reduce in Swift.

let combineOB = Observable.of(5,6,7,8,9).scan(0){ prev, next in
    return prev + next
}.subscribe{
    print("Transform using 'Scan':")
    print($0)
}

    // + Buffer: transforms an Observable that emits items into an Observable that emits buffered collections of those items.

//let emitWithDifferentIntervalsOB = Observable.of(1,2,3,4,5,6)
//    .buffer(timeSpan: 150, count: 4, scheduler: ImmediateSchedulerType.share)
//    .subscribe{
//        print("Transform using 'Buffer':")
//        print($0)
//    }


// Filter : Filtering emitted elements, only taking those meet the condition like in Swift
let oddOB = Observable.of(1,2,3,4,5,6)
    .filter { $0 % 2 != 0}
    .subscribe {
        print("Using 'Filter':")
        print($0)
    }

    // + DistinctUntilChanged: If you just want to emit next Events if the value changed from previous ones you need to use distinctUntilChanged.
let keepChangingOB = Observable.of(1,1,2,2,1,0,4,4,5)
    .distinctUntilChanged()
    .subscribe{
        print("Using filter - 'DistinctUntilChanged':")
        print($0)
    }
    
///There are also other filter like : Debounce, TakeDuration, Skip

// Combine: Combining sequence

    // + startWith :  emit a specific sequence of items before it begins emitting the current items normally

let moreUpFrontOB = Observable.of(4,5,6)
    .startWith(1,2,3)
    .subscribe{
        print("Using Combine - 'StartWith':")
        print($0)
    }

    // + Merge: combine the output of multiple Observables so that they act like a single Observable

let subj1 = PublishSubject<Int>()
let subj2 = PublishSubject<Int>()

let togetherObserveOB = Observable.of(subj1,subj2).merge()
    .subscribe{
        print("Using Combine - 'Merge':")
        print($0)
}

subj1.onNext(1)
subj2.onNext(10)
subj1.onNext(2)
subj1.onNext(3)
subj1.onNext(4)
subj2.onNext(20)
subj1.onNext(5)
subj1.onNext(6)
    
    // + Zip: merge items emitted by different observable sequences to one observable sequence.

    /// Zip will operate in strict sequence,
///      - the first two elements emitted by Zip will be the 1st element of the first sequence and the 1st element of the second sequence combined.
///      - Zip will ONLY emit as many items as the number of items emitted of the source Observables that emits the FEWEST items.
///      EX:
///             a :  1 , 2 , 3 , 4, 5
///             b :  a, b, c, d,
///             => Zip (a,b) = 1a, 2b, 3c, 4d, 5

let aOB = Observable.of(1,2,3,4,5)
let bOB = Observable.of("a","b","c")

// only emits upto 'bOB' as this emits FEWER items than 'aOB'
Observable.zip(aOB,bOB) {
        return ($0,$1)
    }
    .subscribe{
        print("Using Combine - 'Zip':")
        print($0)
    }

    /// Other combination operator like : Concat, CombineLattest, SwitchLatests

// do(On...) :  register callbacks that will be executed when certain events take place on an Observable Sequence
    /// It will NOT MODIFY the emitted elements but rather just pass them through.

    // + do(onNext:) - if you want to do something just if a next event happened
    // + do(onError:) - if errors will be emitted
    // + do(onCompleted:) - if the sequence finished successfully.

Observable.of(1,2,3,4,5).do(onNext: {
    print("On Next Callback")
    $0 * 10 // This has no effect on the actual subscription
}).subscribe(onNext:{
    print("Side Effect - DoOn operator")
    print($0)
})




let o = Observable<Void>.empty()
    
    o.subscribe(
      onNext: { element in
        print("Empty Observable")
        print(element)
    },
      onCompleted: {
        print("Completed")
      }
    )
