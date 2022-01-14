import UIKit
import RxSwift

// Day 9 - Combining Operator
let disposeBag = DisposeBag()

// Prefixing and concatenating

/*
startWith:
 - prefixes an observable sequence with the given initial
 value.
 - This value must be of the same type as the observable elements.
 - Your initial value is a sequence of one element, to which RxSwift appends the sequence that startWith(_:) chains to.
 */

print()
print(">>>>>> startWith() Example:")
print()

let numbers = Observable.of(2,3,4,5)
let observable1 = numbers.startWith(0,1)

observable1
    .subscribe{
    print("observable 1 : ", $0)
    }
    .disposed(by: disposeBag)



/*
    concat:
    - Takes an ordered collection of observables (i.e. an array).
    -  It subscribes to the 1st sequence of the collection, relays its elements until it completes, then moves to the next one.
    - The process repeats until all the observables in the collection have been used.
*/

print()
print(">>>> concat() Example:")
print()

let first = Observable.of(1,2,3)
let second = Observable.of(4,5,6)

let observable2 = Observable.concat([first, second]) //take COLLECTION (like array)

observable2
    .subscribe{
    print("observable 2: ",$0)
    }
    .disposed(by: disposeBag)

/// ANOTHER WAY TO APPEND WITH CONCAT()

let GermanCities = Observable.of("Berlin", "Munich", "Frankfurt")
let SpanishCitties = Observable.of("Madrid", "Barcelona", "Valencia")

let observable3 = GermanCities.concat(SpanishCitties) //use GermanCities as observable for both

observable3
    .subscribe{
    print("observable 3: ",$0)
    }
    .disposed(by: disposeBag)


/*
    concatMap:
    - closely related to flatMap(_:)
    - guarantees that each sequence produced by the closure will run to completion before the next is subscribed to
*/

print()
print(">>>> concatMap() Example:")
print()

//1. Prepares two sequences producing German and Spanish city names.
let sequence = [
    "GermanCities" : Observable.of("Berlin", "Munich", "Frankfurt"),
    "SpanishCitties" : Observable.of("Madrid", "Barcelona", "Valencia")
]

//2. Has a sequence emit country names, each in turn mapping to a sequence emitting city names for this country.
let observable4 = Observable.of("GermanCities", "SpanishCitties")
                    .concatMap {
                        country in sequence[country] ?? .empty()
                    }
//3. Outputs the full sequence for a given country before starting to consider the next one
observable4
    .subscribe{
    print("observable 4: ",$0)
    }
    .disposed(by: disposeBag)

// Merging
/*
    merge:  itself emits observables sequences of the element type. This means you could send a lot of sequences for merge() to subscribe to!
        * To limit the number of sequences subscribed to at once, you can use merge(maxConcurrent:).
    - merge take and  emits any element it received from observable sequences
*/

print()
print(">>>> merge() Example:")
print()

let left = PublishSubject<Int>()
let right = PublishSubject<Int>()
let source = Observable.of(left.asObservable(), right.asObservable())

let observable5 = source.merge()
observable5
    .subscribe{
    print("observable 5: ",$0)
    }
    .disposed(by: disposeBag)

left.onNext(1)

right.onNext(2)
left.onNext(3)
right.onNext(4)

left.onNext(5)

right.onCompleted()
left.onCompleted() // merge DONE after both subjects completed!

// Combining elements
/*
    combineLatest:
    - You receive the last value emitted by each of the inner sequences.
    - Every time one of the inner (combined) sequences emits a value, it calls the closure you provide.
    - Nothing happens until each of the combined observables emits one value.
    - After that, each time one emits a new value, the closure receives the latest value of each of the observable and produces its element.
*/

print()
print(">>>> combineLatest() Example:")
print()

let chu = PublishSubject<String>()
let so = PublishSubject<String>()

let observable6 = Observable
    .combineLatest(chu,so)
    { chu, so in
        // use resultSelector to format your result here!
        "\(chu) : \(so)"
    }
    .filter {!$0.isEmpty} //guarant no empty value passed

observable6
    .subscribe{
    print("observable 6: ",$0)
    }
    .disposed(by: disposeBag)


chu.onNext("Mot")
chu.onNext("Hai")
so.onNext("1")// "1" will pair with "Hai".
            // There will be no ("1" - "Mot") because latest emitted element at current from 'chu' is 'Hai'
so.onNext("2")

chu.onNext("Ba")
so.onNext("3")

// completed
chu.onCompleted()

chu.onNext("Bon") //this will not emited because chu is already completed

// .next element on 'so' will continue pair up with the last emitted element of "chu"
    //before it called onCompleted()
so.onNext("4")
so.onNext("5")
so.onNext("6")

// completed
so.onCompleted()

/*
    zip:
  - zip will:
    * Subscribed to the observables you provided.
    * Waited for each to emit a new value.
    * Called your closure with both new values.
  - They pair each next value of each observable at the same logical position (1st with 1st, 2nd with 2nd, etc.).
    * if no next value from one of the inner observables is available at the next logical position,
         zip won‘t emit anything anymore.
  - In the end, zip won‘t itself complete until all its inner observables complete, making sure each can complete its work.
*/

print()
print(">>>> zip() Example:")
print()

enum Weather {
    case cloudy
    case sunny
}

let weather : Observable<Weather> = Observable.of(.sunny, .cloudy, .sunny)
let places = Observable.of("Ho Chi Minh", "Ha Noi", "Phan Thiet", "Hai Phong")

let observable7 = Observable
    .zip(weather,places) { weather, place in
        "It's \(weather) in \(places)"
    }

observable7
    .subscribe{
        print("observable 7: ",$0)
    }
    .disposed(by: disposeBag)

// Trigger
/*
    withLatestFrom:
    - Create a condition where obsevable 1 emit will trigger it to emit
        the last emitted value of observable 2
 */

print()
print(">>>> withLatestFrom() Example:")
print()

let button = PublishSubject<Void>()
let textField = PublishSubject<String>()

let observable8 = button.withLatestFrom(textField)


observable8
    .subscribe{
    print("observable 8: ",$0)
    }
    .disposed(by: disposeBag)

textField.onNext("H")
textField.onNext("Hel")
textField.onNext("Hello")

button.onNext(()) //when button emit .next event, it will emit the last emitted value of textField
button.onNext(())


/*
    sample:
    - Nearly the same thing withLatestFrom, excepts it won't emitted duplicate value
        If no new data arrived, sample(_:) won’t emit anything.
 */

print()
print(">>>> sample() Example:")
print()

let button2 = PublishSubject<Void>()
let textField2 = PublishSubject<String>()

let observable9 = button2.sample(textField2)

observable9
    .subscribe{
    print("observable 9: ",$0)
    }
    .disposed(by: disposeBag)

textField2.onNext("L")
textField2.onNext("La")
textField2.onNext("Lala")

button2.onNext(()) //when button emit .next event, it will emit the last emitted value of textField
button2.onNext(()) //this time, button won't emits everything because no new data from textField, still "Hello"


//Switches:
/*
    amb:
    - The amb(_:) operator subscribes to observables.
    - It waits for any of them to emit an element, then unsubscribes from the other one. After that, it only relays elements from the first active observable.
 */

print()
print(">>>> amb() Example:")
print()

let names = PublishSubject<String>()
let ages = PublishSubject<String>()

let observable10 = names.amb(ages)

observable10
    .subscribe{
    print("observable 10: ",$0)
    }
    .disposed(by: disposeBag)

// all .next events from 'names' will be emitted because it has emitted first before 'ages'
// amb won't emit anything from 'ages'
names.onNext("Andy1")
names.onNext("Andy2")
names.onNext("Andy3")

ages.onNext("13")
ages.onNext("14")
ages.onNext("15")

names.onNext("Anna1")
names.onNext("Anna2")
names.onNext("Anna3")

ages.onNext("16")
ages.onNext("17")
ages.onNext("18")


/*
    switchLatest:
    - Depend on Source observable emits on which observable, it will listen and emits value only from that observable
 */

print()
print(">>>> switchLatest() Example:")
print()
let names2 = PublishSubject<String>()
let ages2 = PublishSubject<String>()

let observable11 = PublishSubject<Observable<String>>()

observable11
    .subscribe{
    print("observable 11: ",$0)
    }
    .disposed(by: disposeBag)

observable11.onNext(names) //listen to names and only emits its value to subscriber
names2.onNext("Andy1")
names2.onNext("Andy2")
names2.onNext("Andy3")

ages2.onNext("16")
ages2.onNext("17")
ages2.onNext("18")

observable11.onNext(ages) //listen to names and only emits its value to subscriber

ages2.onNext("0")
ages2.onNext("1")
ages2.onNext("3")

observable11.onNext(names) //listen to names and only emits its value to subscriber
names2.onNext("Anna1")
names2.onNext("Anna2")
names2.onNext("Anna3")

// Combining elements within a sequence
/*
    reduce:
     - It starts with the initial value you provide (in the example below, you start with 0).
     - Each time the source observable emits an item, reduce(_:_:) calls your closure to produce a new summary.
     - When the source observable completes, reduce(_:_:) emits the summary value, then completes.

 */

print()
print(">>>> reduce() Example:")
print()

let source1 = Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)

let observable12 = source1.reduce(0, accumulator: +)

observable12
    .subscribe{
    print("observable 12: ",$0)
    }
    .disposed(by: disposeBag)

/// There are different way to write reduce, such as:
///
///             let observable = source.reduce(0) { $0 + $1 }
/// OR
///
///             let observable = source.reduce(0) { summary, newValue in
///                             return summary + newValue }


/*
    scan:
    - Nearly the same as reduce()
    - Each time the source observable emits an element, scan(_:accumulator:) invokes your closure.
     *  It passes the running value along with the new element
     *  the closure returns the new accumulated value.

 */

print()
print(">>>> reduce() Example:")
print()

let observable13 = source1.scan(0, accumulator: +)

observable13
    .subscribe{
    print("observable 13: ",$0)
    }
    .disposed(by: disposeBag)
