import Foundation
import RxSwift

let bag = DisposeBag()

//MARK: 1/ Prefixing and Concatenating

/// Put a sequence of values in front of a stream sequence
func startWith(){
    let observable = Observable.of( "B", "C", "D", "E").startWith("A")
    //A will be emitted before the observable sequence
        
    observable.subscribe(onNext: { value in
        print(value)
    })
    .disposed(by: bag)
}


/**
 Concatenate multiple stream sequence in a collection together.
 
 It will wait for the previous observable to finish to concatenate.
 */
func concatObservable(){
    let first = Observable.of(1, 2, 3)
    let second = Observable.of(4, 5, 6)
    
    let observable = Observable.concat([first, second])
    /*
     concat now will create a new observable using
     the first sequence then append the second sequence
     behind it.
     */
    observable.subscribe(onNext: { value in
        print(value)
    })
    .disposed(by: bag)
}

/// Concatenate the self sequence to the second observable when the the self stream terminated successful.
func concat(){
    let first = Observable.of("A" , "B", "C")
    let second = Observable.of("D" , "E", "F")
    
    let observable = first.concat(second)
    /*
     observable now will wait for when
     first finish to connect second sequence
     */
    observable.subscribe(onNext: { value in
        print(value)
    })
    .disposed(by: bag)
}

/**
    emit items from an observable after their transformation in the order they are emitted.
 */
func contcatMap() {
    let cities = [
        "MienBac":Observable.of("HaNoi", "HaiPhong"),
        "MienTrung":Observable.of("Hue", "DaNang"),
        "MienNam":Observable.of("HoChiMinh", "CanTho")
    ]
    
    let observable = Observable.of("MienBac", "MienTrung", "MienNam")
        .concatMap { (name) in      //(*)
            cities[name] ?? .empty()
        }
    
    observable
        .subscribe(onNext: { print($0) })
        .disposed(by: bag)
}

/**
Create a new observable whenever an observable contains an element of type observable.
 
 - The observable created by merge will end when all observable elements is terminated.
 
 - The operator will include all items emitted by the observable elements regardless  of the Observable  adding order.
 
 - To limit the number of Observable merging use : .merge(maxConcurrent:)
 */

//MARK: /2 Merging

func merging() {
    let chu = PublishSubject<String>()
    let so = PublishSubject<String>()
    
    let source = Observable.of(chu.asObserver(), so.asObserver())
    let observable = source.merge()
    
    observable.subscribe(onNext: { value in
        print(value)
    })
    .disposed(by: bag)
    
    chu.onNext("Mot")
    so.onNext("1")
    chu.onNext("Hai")
    so.onNext("2")
    chu.onNext("Ba")
    //completed
    so.onCompleted()
    
    so.onNext("3")
    chu.onNext("Bon")
    //completed
    chu.onCompleted()
}


//MARK: 3/ Combining elements

/**
 Merges the last 2 element of 2 observable sequence into an observable sequence of tuples whenever one of the observable emit an element.
 
 If 1 of the observable is .completed then the other observable will keep using the last element emitted.
 */
func combineLatest() {
    let chu = PublishSubject<String>()
    let so = PublishSubject<String>()
    
    let observable = Observable.combineLatest(chu, so)
    
    observable
        .subscribe(onNext: { value in
            print(value)
        })
        .disposed(by: bag)
    
    //start emitting
    chu.onNext("Mot")
    chu.onNext("Hai")
    so.onNext("1")
    so.onNext("2")
    
    chu.onNext("Ba")
    so.onNext("3")
    
    //completed
    chu.onCompleted()
    
    chu.onNext("Bon")
    so.onNext("4")
    so.onNext("5")
    so.onNext("6")
    
    //completed
    so.onCompleted()
}

/**
 Works like the map operator where you can change the type of the output of combineLatest operator
 
 *combineLatest(_:_:resultSelector:)
 */
func resultSelector() {
    let chu = PublishSubject<String>()
    let so = PublishSubject<String>()
    
    let observable = Observable
        .combineLatest(chu, so) { (chu, so) in
            "\(chu):\(so)"
        }
    
    observable
        .subscribe(onNext: { value in
            print(value)
        })
        .disposed(by: bag)
    
    //start emitting
    chu.onNext("Mot")
    chu.onNext("Hai")
    so.onNext("1")
    so.onNext("2")
    
    chu.onNext("Ba")
    so.onNext("3")
    
    //completed
    chu.onCompleted()
    
    chu.onNext("Bon")
    so.onNext("4")
    so.onNext("5")
    so.onNext("6")
    
    //completed
    so.onCompleted()
}

func resultSelectorEx() {
    let choice: Observable<DateFormatter.Style> = Observable.of(.short, .long)
    let dates = Observable.of(Date())
    
    let observable = Observable.combineLatest(choice, dates) { (format, when) -> String in
        let formatter = DateFormatter()
        formatter.dateStyle = format
        return formatter.string(from: when)
    }
    
    _ = observable.subscribe(onNext: {value in
            print(value)
        }).disposed(by: bag)
}

/**
 merges 2 item according to their position in a sequence whenever each observable emit a new value
 */
func zip() {
    let chu = PublishSubject<String>()
    let so = PublishSubject<String>()
    
    let observable = Observable
        .zip(chu, so) { (chu, so) in
            "\(chu):\(so)"
        }
    
    observable
        .subscribe(onNext: { value in
            print(value)
        })
        .disposed(by: bag)
    
    //start emitting
    chu.onNext("Mot")
    chu.onNext("Hai")
    so.onNext("1")
    so.onNext("2")
    
    chu.onNext("Ba")
    so.onNext("3")
    
    //completed
    chu.onCompleted()
    
    chu.onNext("Bon")
    so.onNext("4")
    so.onNext("5")
    so.onNext("6")
    
    //completed
    so.onCompleted()
}

//MARK: 4/ Trigger

/**
 Used the first observable sequence as a trigger for when to merge the values.
 - Note: Any element emit before the trigger emit it value is omitted.
 */
func withLatestFrom() {
    let button = PublishSubject<Void>()
    let textField = PublishSubject<String>()
    
    let observable = button.withLatestFrom(textField)
    
    _ = observable.subscribe(onNext: { value in
        print(value)
    })
    
    textField.onNext("Da")
    textField.onNext("DaNa")
    textField.onNext("DaNang")
    
    button.onNext(())
    button.onNext(())
}

/**
 A trigger that used other observable as trigger.
 
 Whenever the observable trigger(button) emit the left observable(textField) start emitting with the trigger new emitted value.
 
 - note:
 - whenever the trigger is called if the left observable doesn't emit any new value then it will return nil.
 - To provide a default value use: .sample(_:defaultValue:)
 */

func sample() {
    let button = PublishSubject<Void>()
    let textField = PublishSubject<String>()
    
    let observable = textField.sample(button,defaultValue: nil)
    
    _ = observable.subscribe(onNext: { value in
        print(value)
    })
    
    textField.onNext("Da")
    textField.onNext("DaNa")
    textField.onNext("DaNang")
    
    button.onNext(())
    button.onNext(())
}

//MARK: 5/ Switches

/**
 Only take 1 of the 2 observable values depending on which one emit first.
 */
func ambiguity() {
    let chu = PublishSubject<String>()
    let so = PublishSubject<String>()
    
    let observable = chu.amb(so)
    
    observable
        .subscribe(onNext: { value in
            print(value)
        })
        .disposed(by: bag)
    
    so.onNext("1")
    so.onNext("2")
    so.onNext("3")
    
    chu.onNext("Mot")
    chu.onNext("Hai")
    chu.onNext("Ba")
    
    so.onNext("4")
    so.onNext("5")
    so.onNext("6")
    
    chu.onNext("Bon")
    chu.onNext("Nam")
    chu.onNext("Sau")
}

/**
 Only take element from the latest observable in the sequence.
 
 - note: The original observable has to be an observable emitting other observable.
 
 To terminate the original observable you have to use .dispose.
 */

func switchLatest() {
    typealias StringStream = PublishSubject<String>
    
    let chu = StringStream()
    let so = StringStream()
    let dau = StringStream()
    
    let observable = PublishSubject<StringStream>() //original observable
    
    observable
        .switchLatest()
        .subscribe(onNext: { print($0) },
                   onCompleted: {print("completed")})
        .disposed(by: bag)
    
    observable.onNext(so)
    
    so.onNext("1")
    so.onNext("2")
    so.onNext("3")
    
    observable.onNext(chu)
    
    chu.onNext("Mot")
    chu.onNext("Hai")
    chu.onNext("Ba")
    
    so.onNext("4")
    so.onNext("5")
    so.onNext("6")
    
    observable.onNext(dau)
    
    dau.onNext("+")
    dau.onNext("-")
    
    observable.onNext(chu)
    
    chu.onNext("Bon")
    chu.onNext("Nam")
    chu.onNext("Sau")
    
    observable.dispose() //call to terminate
}

//MARK: 6/ Combining elements within a sequence

/**
 Perform a function recursively throughout the entire sequence with a summary parameter. The function will return the summarry value after the observable is terminated.
 */
func reduce() {
    let source = Observable.of( 1, 2, 3, 4, 5, 6, 7, 8, 9)
    let observable = source.reduce(0, accumulator: +)
        
    _ = observable.subscribe(onNext: { print($0) })
}


/**
 Perform like reduce but instead of returning the value to subscriber when the observable ended it will return everytime it iterate through a value in the sequence.
 - note: reduce is a way to make a for loop with RxSwift.
 */
func scan() {
    let source = Observable.of( 1, 2, 3, 4, 5, 6, 7, 8, 9)
    
//    let observable = source.scan(0, accumulator: +)
//    let observable = source.scan(0){ $0 + $1 }
    
    let observable = source.scan(0) { (summary, newValue) in
        summary + newValue
    }
    
    observable
        .subscribe(onNext: { value in
            print(value)
        })
        .disposed(by: bag)
}

scan()

/* Note:
 +startWith: is used to append elements or sequence in front of an observable sequence.
 +concat: is used to combine observable together or to keep emitting after 1 observable has finished by emit using another observable.
 +concatMap: like concat but now can change the type of the element output of an observable.
 +merge: combine all the values of various observables onto a new observable (regardless of order)
 +combineLatest: merge 2 latest values that was emitted by either observable regardless of when they were emitted by the observables.
 +zip: like combineLatest but only merges the values if they were the same order emitted.
 +withLatestFrom: a trigger that respond using values from other observable.
 +sample: a trigger using other observable. Whenever the trigger emit the observable will start emit it values, if the observable hasn't emitted any value then it will emit nil.
 +amb: determine which observable values to emit by whom emit first.
 +switchLatest: only emit values of the latest observable.
 +reduce: performing work to make all values in a sequence into a single value and hand it to the subscriber when the observabel terminate.
 +scan: similar to reduce but will return the value each time the work is done .
 */

