import UIKit
import RxSwift

//1/ Transforming elements

let bag = DisposeBag()

func transformingElements() {
    Observable.of(1,2,3,4,5,6)
        .toArray() ///transform the observable into a single
        .subscribe(onSuccess: { values in
            print(values)
        })
        .disposed(by: bag)
    ///return a success value containing an array of Int
}

/*:
 Note: a single is a variant of observable that is instead of subscribing to 3 method to respond to an observable notification (onNext, onError, onCompleted) you use only 2 method:
        +onSuccess: the single passes this method the item it emit.
        +onError: the single passes the error.
 */

//2/ map
func map() {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    Observable<Int>.of( 1, 2, 3, 4, 5, 10, 999, 9_999, 1_000_000)
        .map{ formatter.string(for: $0) ?? "" }
        .subscribe(onNext: { string in
            print(string)
        })
        .disposed(by: bag)
    
    Observable.of( 1, 2, 3, 4, 5, 6)
        .enumerated()
        .map{ (index, element) in
            index > 2 ? element * 2 : element
        }
        .subscribe(onNext: { print($0)} )
        .disposed(by: bag)
}
///For loop using Rx

//Transforming inner Observable.

struct User {
    let message: BehaviorSubject<String>
}

//flatmap

func flatmap() {
    let cuTy = User(message: BehaviorSubject(value: "Cu Ty chao ban!"))
    let cuTeo = User(message: BehaviorSubject(value: "Cu Teo chao ban!"))
    
    let subject = PublishSubject<User>()
    ///original Observable emitting other observables.
    
    subject
        .flatMap { user in
            user.message ///Changing the user into a string
        }
        .subscribe(onNext: { msg in
            print(msg)
        })
        .disposed(by: bag)
    
    //1
    subject.onNext(cuTy)
    //cuTy emit default value
    //2~5
    cuTy.message.onNext("Co ai o day khong?")
    cuTy.message.onNext("Co 1 minh minh thoi a!")
    cuTy.message.onNext("Buon vay!")
    cuTy.message.onNext("...")
    //6
    subject.onNext(cuTeo)
    //cuTeo emit default value
    //7
    cuTy.message.onNext("Chao Teo, ban co khoe khong?")
    //8
    cuTeo.message.onNext("Chao Ty, minh khoe. Con ban thi sao?")
    //9-10
    cuTy.message.onNext("Minh cung khoe luon")
    cuTy.message.onNext("Minh dung day tu chieu ne")
    //11
    cuTeo.message.onNext("Ke Ty. Ahihi")
}


/*
 Note: flatmap can be used to make an observables emit other observable then getting all the observables values on the original observable.
 */

func flatmapLatest() {
    let cuTy = User(message: BehaviorSubject(value: "Cu Ty chao ban!"))
    let cuTeo = User(message: BehaviorSubject(value: "Cu Teo chao ban!"))
    
    let subject = PublishSubject<User>()
    ///original Observable emitting other observables.
    
    subject
        .flatMapLatest({ $0.message })
        .subscribe{ print($0)}
        .disposed(by: bag)
    
    //1
    subject.onNext(cuTy)
    //cuTy emit default value
    
    //2~5
    cuTy.message.onNext("Co ai o day khong?")
    cuTy.message.onNext("Co 1 minh minh thoi a!")
    cuTy.message.onNext("Buon vay!")
    cuTy.message.onNext("...")
    //6
    subject.onNext(cuTeo)
    //cuTeo emit default value
    
    //7
    ///ignored
    cuTy.message.onNext("Chao Teo, ban co khoe khong?")
    //8
    cuTeo.message.onNext("Chao Ty, minh khoe. Con ban thi sao?")
    //9-10
    ///ignored
    cuTy.message.onNext("Minh cung khoe luon")
    cuTy.message.onNext("Minh dung day tu chieu ne")
    //11
    cuTeo.message.onNext("Ke Ty. Ahihi")
}

/*
 Note: the original observable only take the value of the latest observable that is being emitted by it
 */

//3/ observing events
//error

enum MyError: Error {
    case anError
}

func observingError() {
    let cuTy = User(message:BehaviorSubject(value: "Cu Ty chao ban"))
    let cuTeo = User(message: BehaviorSubject(value: "Cu Teo chao ban"))
    
    let subject = PublishSubject<User>()
    
    let roomChat = subject.flatMap{ $0.message }
    
    roomChat
        .subscribe(onNext: { msg in
            print(msg)
        })
        .disposed(by: bag)
    
    //1
    subject.onNext(cuTy)
    
    //2~4
    cuTy.message.onNext("Ty: A")
    cuTy.message.onNext("Ty: B")
    cuTy.message.onNext("Ty: C")
    
    //5
    cuTy.message.onError(MyError.anError)
    //terminated.
    
    cuTy.message.onNext("Ty: D")
    cuTy.message.onNext("Ty: E")
    
    subject.onNext(cuTeo)
    
    cuTeo.message.onNext("Teo: 1")
    cuTeo.message.onNext("Teo: 2")
}

//materialize

func materialize() {
    let cuTy = User(message:BehaviorSubject(value: "Cu Ty chao ban"))
    let cuTeo = User(message: BehaviorSubject(value: "Cu Teo chao ban"))
    
    let subject = PublishSubject<User>()
    
    let roomChat = subject.flatMap{ $0.message.materialize() }
    //Roomchat is now of type Observable<Event<String>> meaning all event are now elemen in the room chat sequence
    roomChat
        .subscribe(onNext: { msg in
            print(msg)
        })
        .disposed(by: bag)
    
    //1
    subject.onNext(cuTy)
    
    //2~4
    cuTy.message.onNext("Ty: A")
    cuTy.message.onNext("Ty: B")
    cuTy.message.onNext("Ty: C")
    
    //5
    ///terminate cuTy Observable
    cuTy.message.onError(MyError.anError)
    
    //6-7
    ///terminated so this part is ignored
    cuTy.message.onNext("Ty: D")
    cuTy.message.onNext("Ty: E")
    
    //8
    subject.onNext(cuTeo)
    
    //9-10
    cuTeo.message.onNext("Teo: 1")
    cuTeo.message.onNext("Teo: 2")
}

//dematerialize

func dematerialize() {
    let cuTy = User(message:BehaviorSubject(value: "Cu Ty chao ban"))
    let cuTeo = User(message: BehaviorSubject(value: "Cu Teo chao ban"))
    
    let subject = PublishSubject<User>()
    
    let roomChat = subject.flatMap{ $0.message.materialize() }
    //Roomchat is now of type Observable<Event<String>> meaning all event are now elemen in the room chat sequence
    roomChat
        .filter { event in
            guard event.error == nil else { //skipping an onError event
                print("Error: \(event.error!)")
                return false
            }
            
            return true
        }
        .dematerialize() //converting the materialized event back into element.
        .subscribe(onNext: { msg in
            print(msg)
        })
        .disposed(by: bag)
    
    subject.onNext(cuTy)
    
    cuTy.message.onNext("Ty: A")
    cuTy.message.onNext("Ty: B")
    cuTy.message.onNext("Ty: C")
    
    //onError event on cuTy
    cuTy.message.onError(MyError.anError)
    
    cuTy.message.onNext("Ty: D")
    cuTy.message.onNext("Ty: E")
    
    subject.onNext(cuTeo)
    
    cuTeo.message.onNext("Teo: 1")
    cuTeo.message.onNext("Teo: 2")
}

/*
 Note: You can use materialize to get event that observable is emitting and dematerialize to extract element from event
 */

///Summary:
/// +toArray: Convert all element in a sequence into an array and return it when the stream end.
/// +map: Convert Type of element.
/// +flatmap: Combine all Observable into 1 single observable with element from all of the observable it emitted regardless of subscription order.
/// +flatmapLatest: flatmap but only getting the value of latest observable.
/// +materialized: turn all of the element into event.
/// +dematerialized: Extract element out of event.


