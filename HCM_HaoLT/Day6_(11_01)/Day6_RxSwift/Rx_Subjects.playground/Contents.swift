import UIKit
import RxSwift
import RxCocoa
import Combine


//--------- RxSwift - SUBJECT ---------


//// Publish Subject :
///*
//     + Get all the events that will happen after you subscribed.
//     + It’s of type String, so it can ONLY receive and publish strings.
// */
//
//// 1. Create PubishSubject
//var subject = PublishSubject<String>()
//
//// 2. This puts a new string onto the 'subject', but nothing is printed out yet, because there are no observers.
//subject.onNext("Yo!")
//
//// 3. Create observer by subcribing to 'subject'
//let subscription1 = subject.subscribe(
//    onNext: { string in
//    print("On subcriber #1: " + string)
//    },
//    onCompleted: {print("Completed!")},
//    onDisposed: {print("Disposed!")}
//  )
//
//// 4. Now, because subject has a subscriber (subscription1), when it emit new value, subscriber will get string "Hello", "World"
//subject.onNext("Hello") // add new value to sequence
//subject.onNext("World")
//    ///NOTE: If you subscribe to that subject after adding “Hello” and “World” using onNext(), you won’t receive these two values through events.
//
//// 5. Create another observer (subcription2) subcribe to the channel
//
//let subscription2 = subject.subscribe{ event in
//    //use the nil-coalescing operator here to print the element if there is one;
//        // otherwise, you print the event.
//        print("On subcriber #2:", event.element ?? event)
//}
//
//// 6. When emit new value, the string is printed out twice (2x), one for subscription1 and one for subscription2
//subject.onNext("subcriber #2 starts subscribing")
//
//// 7. Dispose subscription1
//subscription1.dispose()
//
//// 8. Add another 'next' event
////  The string is only printed out one time only (on subcriber #2) because subcriber #1 was disposed
//subject.onNext("subcriber #1 has left")
//
//
//// 9. Add a completed event onto the subject
//subject.onCompleted()
//
//// 10. Add another element onto the 'subject'
////  This won’t be emitted and printed, though, because the subject has already terminated.
//subject.onNext("Subject is terminated")
//
//// 11. Dispose subscription2
//subscription2.dispose()
//
//let disposeBag = DisposeBag()
//
//// 12. Subscribe to the subject, this time adding its disposable to a dispose bag.
//
////  Subjects, once terminated, will re-emit their stop event to future subscribers.
////  In the ouput, you will see the 'completed' event replayed
//subject
//  .subscribe {
//    print("On subcriber #3", $0.element ?? $0)
//  }
//  .disposed(by: disposeBag)
//
//// 13. When 'subject' is terminated, it's no longer emit next event.
//    // Therefore, new subscriber WILL NOT bring 'subject' back after it terminated
//        // meaning, you will never get this line print out.
//subject.onNext("Subscriber #3 start subscribing, but the channel is off")


// Behavior subjects :
/*
     + Behavior subjects work similarly to publish subjects, except they will replay the latest next event to new subscribers
    
 */
let disposeBag = DisposeBag()

// 1. Define an error type
enum MyError: Error {
  case anError
}

// 2. Create a helper function to print the element if there is one, an error if there is one, or else the event itself.
func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
  print(label, (event.element ?? event.error) ?? event)
}

// 3. Create a new BehaviorSubject instance. Its initializer takes an initial value
let behavorialSubject = BehaviorSubject(value: "Initial value")

// 4. Subscribe behavorialSubject
    // Because no other elements have been added to the subject, it replays its initial value to the subscriber.
/// NOTE: if we add an 'next' event.first before we subcribe it,
/// then the lattest element that will be printed out is the element in the 'next' event, not the initial value
behavorialSubject
  .subscribe {
    print(label: "1st Subscribing: ", event: $0)
  }
  .disposed(by: disposeBag)

// 5. Emits an error event onto behavorialSubject and terminate
behavorialSubject.onError(MyError.anError)

// 6. Create subcription #2 to behavorialSubject
    //Similar to PublishSubject, behavior subjects replay their latest value to new subscribers.
behavorialSubject
  .subscribe {
    print(label: "2nd Subscribing:", event: $0)
  }
  .disposed(by: disposeBag)
