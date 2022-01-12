import UIKit
import RxSwift
import RxCocoa
import Combine


//--------- RxSwift - SUBJECT ---------


// Publish Subject :
/*
     + Get all the events that will happen after you subscribed.
     + It’s of type String, so it can ONLY receive and publish strings.
 */
print()
print(">>>>>PublishSubject Example: ")
print()
// 1. Create PubishSubject
var subject = PublishSubject<String>()

// 2. This puts a new string onto the 'subject', but nothing is printed out yet, because there are no observers.
subject.onNext("Yo!")

// 3. Create observer by subcribing to 'subject'
let subscription1 = subject.subscribe(
    onNext: { string in
    print("On subcriber #1: " + string)
    },
    onCompleted: {print("Completed!")},
    onDisposed: {print("Disposed!")}
  )

// 4. Now, because subject has a subscriber (subscription1), when it emit new value, subscriber will get string "Hello", "World"
subject.onNext("Hello") // add new value to sequence
subject.onNext("World")
    ///NOTE: If you subscribe to that subject after adding “Hello” and “World” using onNext(), you won’t receive these two values through events.

// 5. Create another observer (subcription2) subcribe to the channel

let subscription2 = subject.subscribe{ event in
    //use the nil-coalescing operator here to print the element if there is one;
        // otherwise, you print the event.
        print("On subcriber #2:", event.element ?? event)
}

// 6. When emit new value, the string is printed out twice (2x), one for subscription1 and one for subscription2
subject.onNext("subcriber #2 starts subscribing")

// 7. Dispose subscription1
subscription1.dispose()

// 8. Add another 'next' event
//  The string is only printed out one time only (on subcriber #2) because subcriber #1 was disposed
subject.onNext("subcriber #1 has left")


// 9. Add a completed event onto the subject
subject.onCompleted()

// 10. Add another element onto the 'subject'
//  This won’t be emitted and printed, though, because the subject has already terminated.
subject.onNext("Subject is terminated")

// 11. Dispose subscription2
subscription2.dispose()

let disposeBag = DisposeBag()

// 12. Subscribe to the subject, this time adding its disposable to a dispose bag.

//  Subjects, once terminated, will re-emit their stop event to future subscribers.
//  In the ouput, you will see the 'completed' event replayed
subject
  .subscribe {
    print("On subcriber #3", $0.element ?? $0)
  }
  .disposed(by: disposeBag)

// 13. When 'subject' is terminated, it's no longer emit next event.
    // Therefore, new subscriber WILL NOT bring 'subject' back after it terminated
        // meaning, you will never get this line print out.
subject.onNext("Subscriber #3 start subscribing, but the channel is off")


// Behavior subjects :
/*
     + Behavior subjects work similarly to publish subjects, except they will replay the latest next event to new subscribers
    
 */
print()
print(">>>>>BehaviorSubject Example: ")
print()

//let disposeBag = DisposeBag()

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


// ReplaySubject
/*
    + Replay subjects will temporarily cache, or buffer, the latest elements they emit, up to a specified size of your choosing. They will then replay that buffer to new subscribers.
 */
print()
print(">>>>>ReplaySubject Example: ")
print()

// 1. Create a new replay subject with a buffer size of 2
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
/// let disposeBag = DisposeBag()

// 2. Add 3 elements onto the subject
replaySubject.onNext("1")
replaySubject.onNext("2")
replaySubject.onNext("3")

// 3. Create 2 subscriptions to the subject.
//      + The latest two elements are replayed to both subscribers which is '2' and '3'
//          because the buffer size is 2, meaning take only 2 latest elements

replaySubject
    .subscribe {
    print(label: "Subscriber #1: ", event : $0)
    }
    .disposed(by: disposeBag)

replaySubject
    .subscribe {
    print(label: "Subscriber #2: ", event : $0)
    }
    .disposed(by: disposeBag)

// 4. Add another element onto subject

replaySubject.onNext("4")

// 5. Emits error event
replaySubject.onError(MyError.anError)

////5a. Explicitly call dispose() - NOT COMMON TO DO
////     if doing this, subcriber #3 will only recieve the re-emitted stop events,
////      BUT not recieving the buffer elements
////replaySubject.dispose()

// 6. Create another subscription to the subject.
//      + replaySubject will re-emit stop event to new subsciber #3
//      + replaySubject will replay buffer elements to new subscriber #3 before it re-emitted stop event

replaySubject
  .subscribe {
    print(label: "Subscriber #3: ", event: $0)
  }
  .disposed(by: disposeBag)


// Relays
/*
 - A relay wraps a subject while maintaining its replay behavior.
 - You add a value onto a relay by using the accept(_:) method. You DON'T use onNext(_:)
 -  You CANNOT add an error or completed event onto them. WE will get compile error if do so
 - A PublishRelay wraps a PublishSubject and a BehaviorRelay wraps a BehaviorSubject.
 */

print()
print(">>>>>PublishRelay Example: ")
print()

let relay = PublishRelay<String>()
//let disposeBag = DisposeBag()

//add new element to relay
relay.accept("Knock knock, anyone home?") // There are no subscribers yet, so nothing is emitted.

//create a subscriber
relay
  .subscribe(onNext: {
    print("Subscriber #1: " + $0)
  })
  .disposed(by: disposeBag)

//add another new element to relay
relay.accept("New sub #1 is added")


// BehaviorReplay
/*
    + Behavior relays also will not terminate with a completed or error event.
    + A behavior relay is created with an initial value, and it will replay its latest or initial value to new subscribers.
    + You can ask it for its current value at any time.
 */

print()
print(">>>>>BehaviorReplay Example: ")
print()


// 1. Create a behavior relay with an initial value
    ///NOTE: The relay’s type is inferred, but you could also explicitly declare the type as:
    /// BehaviorRelay<String>(value: "Initial value")
    ///
let behaviorRelay = BehaviorRelay(value: "Initial value")

// 2. Add a new element onto the relay.
behaviorRelay.accept("New initial value")

// 3. Subscribe to the relay.
    // Subscriber will recieved the latest element or initial value that is emitted before it
behaviorRelay
    .subscribe {
      print(label: "Subscription 1: ", event: $0)
    }
    .disposed(by: disposeBag)

// 4. Add another new element
behaviorRelay.accept("1")

// 5. Add another subscriber
behaviorRelay
  .subscribe {
    print(label: "Subscription 2: ", event: $0)
  }
  .disposed(by: disposeBag)

// 6. Add another new element
behaviorRelay.accept("2")

// 7. Behavior relays let you directly access their current value.
print("Current value in behavior relay: " + behaviorRelay.value)
