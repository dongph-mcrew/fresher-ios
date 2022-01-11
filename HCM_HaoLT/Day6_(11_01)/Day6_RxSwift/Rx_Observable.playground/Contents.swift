import UIKit
import RxSwift
import RxCocoa
import Combine

//--------- RxSwift - OBSERVABLE ---------

/* - Observable sequence TYPE:
        + just
        + of
        + from
 */

let iOS = 1
let android = 2
let flutter = 3

// 1. just
// one-time subscribing

let observable1 = Observable<Int>.just(iOS)
//sampleRx.subscribe{ (value) in
//    print(value)
//}

// 2. of
// no need to declare input type
let observable2 = Observable.of(iOS, android, flutter) // input Int
let observable3 = Observable.of([iOS, android, flutter]) // input [Int]


// 3. from
// input is array type
let observable4 = Observable.from([iOS, android, flutter])


// - Flow
// 1. Creating a DisposeBag so subscribtion will be cancelled correctly
let bag = DisposeBag()

// 2. Creating an Observable Sequence that emits a String value
let observable = Observable.just("Hello Rx!")

// 3. Creating a subscription just for next events
let subscription = observable.subscribe { event in
    switch event {
    case .next(let value):
        print(value)
    case .error(let error):
        print(error)
    case .completed:
        print("Completed")
    }
}

// 4. Adding the Subscription to a Dispose Bag, which
    // cancel the subscription for you automatically on deinit of the DisposeBag Instance.
subscription.disposed(by: bag)


// - Using create(..) to create observable
/*
    + The create operator takes a single parameter named subscribe.
    + Its job is to provide the implementation of calling subscribe on the observable
    + The 'subscribe' parameter is an escaping closure that takes an AnyObserver and returns a Disposable
 */
let disposeBag = DisposeBag()

enum MyError: Error {
  case anError
}

Observable<String>.create { observer in
    //1. Add a next event onto the observer
    observer.onNext("1")
    
    /// Emit error here!
    ///     Observerable will emit error event & terminate
    observer.onError(MyError.anError)
   
//    //2. Add a complete ebent onto the observer
    observer.onCompleted()
    
    //3. Add another next event onto the observer
        // This will not be printed out because the observable emitted a Completed event and terminated above
    observer.onNext("?")
    
    //4. Return a disposable, defining what happens when your observable is terminated or disposed of;
    //  In this case, no cleanup is needed so you return an empty disposable.
    return Disposables.create()
}.subscribe(
    onNext: {print($0)},
    onError: {print($0)},
    onCompleted: {print("Completed!")},
    onDisposed: {print("Disposed!")}
  )
 .disposed(by: disposeBag)



// Creating observable factories
/*
    + It’s possible to create observable factories that vend a new observable to each subscriber.
 */


//let disposeBag = DisposeBag()

// 1. Create a Bool flag to flip which observable to return.
var flip = false

// 2. Create an observable of Int factory using the deferred operator.
let factory: Observable<Int> = Observable.deferred{
    
    //3. Toggle flip, which happens each time factory is subscribed to.
    flip.toggle()
    
    //4. Return different observables based on whether flip is true or false.
    if flip {
        return Observable.of(1,2,3)
    }
    else {
        return Observable.of(4,5,6)
    }
}

// 5. To subscribe to 'factory' four times
    // Each time you subscribe to factory, you get the opposite observable.
for _ in 0...3 {
  factory.subscribe(onNext: {
    print($0, terminator: "")
  })
  .disposed(by: disposeBag)

  print() // print next output to next line
}


// Using traits : Single , Maybe, Completable

/*
  - Single:
    + Singles will emit either a success(value) or failure(error) event.
    + Emits exactly one element, or an error.
 */

// 1. Create a dispose bag to use later
let disposeBAG = DisposeBag()

// 2. Define an Error enum to model some possible errors that can occur in reading data from a file on disk.

enum FileReadError : Error {
    case fileNotFound, unreadable, encodingFailed
}

// 3. Implement a function to load text from a file on disk that returns a Single.
func loadText(from name : String) -> Single<String> {
   // 4. Create and return a Single.
    return Single.create { single in
        
        // a. Create a Disposable, because the subscribe closure of create expects it as its return type
        let disposable = Disposables.create()

        // b. Get the path for the filename, or else add a file not found error onto the Single and return the disposable you created.
        guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
            single(.failure(FileReadError.fileNotFound))
          return disposable
        }

        // c. Get the data from the file at that path, or add an unreadable error onto the Single and return the disposable.
        guard let data = FileManager.default.contents(atPath: path) else {
          single(.failure(FileReadError.unreadable))
          return disposable
        }

        // d.Convert the data to a string; otherwise, add an encoding failed error onto the Single and return the disposable.
        guard let contents = String(data: data, encoding: .utf8) else {
          single(.failure(FileReadError.encodingFailed))
          return disposable
        }

        // e. Add the contents onto the Single as a success, and return the disposable.
        single(.success(contents))
        
        return disposable
    }
}
// 5. Call loadText(from:) and pass the root name of the text file.
loadText(from: "Copyright")
// 6. Subscribe to the Single it returns.
  .subscribe {
    // Switch on the event and print the string if it was successful, or print the error if not.
    switch $0 {
    case .success(let string):
      print(string)
    case .failure(let error):
      print(error)
    }
  }
  .disposed(by: disposeBag)




