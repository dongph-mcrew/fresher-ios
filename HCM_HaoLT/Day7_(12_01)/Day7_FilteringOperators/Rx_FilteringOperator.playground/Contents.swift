import UIKit
import RxSwift
import RxCocoa
import Combine

let disposeBag = DisposeBag()

// Ignoring operator
/*
>>>>> ignoreElements()
 - ignore .next event elements.
 - However, it will allow stop events through, such as .completed or .error events.
 */

print()
print(">>>>>ignoreElements() Example: ")
print()

// 1. Create a subject
 let subject = PublishSubject<String>()

// 2. Subscribe to all subject’s events, but ignore all .next events by using ignoreElements.
subject
   .ignoreElements()
   .subscribe {
     print("Subcriber #1: ", $0)
   }
   .disposed(by: disposeBag)

//3. Add new elements to subject
    //Subscriber will not recieve .next event because it all got ignored
subject.onNext("Add 1")
subject.onNext("Add 2")
subject.onNext("Add 3")

//4. Add stop event onto subject
    //subscriber will receive the .completed event, and print out the message
subject.onCompleted()


/*
 >>>>> elementAt
 - Takes the index of the element you want to receive, and it ignores everything else
-  As soon as an element is emitted at the provided index, the subscription will be terminated.
*/

print()
print(">>>>>elementAt() Example: ")
print()

// 1. Create a subject.
 let subject2 = PublishSubject<String>()

// 2. Subscribe to the subject, and ignore every .next event except the 3rd element (index = 2)
subject2
    .element(at: 2) //only care about 3rd element (index = 2)
    .subscribe {
        print("Subscriber #1: ", $0)
    }
    .disposed(by: disposeBag)

// 3. Add .next events onto subject
subject2.onNext("Add 1")
subject2.onNext("Add 2")
subject2.onNext("Add 3") // Subsriber #1 will catch only this one!

// 4. Add another subscriber
subject2
    .element(at: 2) //only care about 3rd element (index = 2)
    .subscribe {
        print("Subscriber #2: ", $0)
    }
    .disposed(by: disposeBag)

//5. Add more .next events onto subject
subject2.onNext("Add 4")
subject2.onNext("Add 5")
subject2.onNext("Add 6") // Subsriber #2 will catch only this one!
subject2.onNext("Add 7")
subject2.onNext("Add 8")


/*
 >>>>>filter
 - It takes a predicate closure, which it applies to every element emitted, allowing through only those elements for which the predicate resolves to true.
*/
print()
print(">>>>>filter() Example: ")
print()

// 1. Create an observable of some predefined integers.
Observable.of(1, 2, 3, 4, 5, 6)
// 2. You use the filter operator to apply a conditional constraint to prevent odd numbers from getting through.
.filter { $0 % 2 == 0 }

// 3. subscribe and print out the elements that pass the filter predicate.
.subscribe{
    print("Subscriber #1: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

///ANOTHER EXAMPLE
// create subject
let subj3 = PublishSubject<String>()
//add subscription with filter
subj3
    .filter({ item in
        item.contains("H")
    })
.subscribe{
    print("Subscriber #2: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

//add elements to subject
subj3.onNext("Hello")
subj3.onNext("Lanna")
subj3.onNext("Iam")
subj3.onNext("Hungry")
subj3.onNext("I wanna")
subj3.onNext("CHICKEN!!")

//terminate
subj3.onCompleted()


// Skipping operator
/*
>>>>> skip()
 - skip operator allows you to ignore from the 1st to the number you pass as its parameter.
 */

print()
print(">>>>>skip() Example: ")
print()

// 1. Create an observable of letters.
Observable.of("A", "B", "C", "D", "E", "F")

// 2. skip the first 3 elements and subscribe to .next events.
.skip(3)
.subscribe {
    print("Subscriber #2: ", $0.element ?? $0)
}
.disposed(by: disposeBag)


///ANOTHER EXAMPLE
print()
// create subject
let subj4 = PublishSubject<String>()

//add subscription with skipping 3 elements
subj4
.skip(3)
.subscribe{
    print("Subscriber #2: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

//add elements to subject
subj4.onNext("Hello")
subj4.onNext("Lanna")
subj4.onNext("Iam")
subj4.onNext("Hungry")
subj4.onNext("I wanna")
subj4.onNext("CHICKEN!!")

//terminate
subj4.onCompleted()


/*
 >>>>> skip(while:...)
 - Lets you include a predicate to determine what should be skipped.
 - Only skip up until something is not skipped, and then it will let everything else through from that point on.
 - Returning true will cause the element to be skipped, and returning false will let it through.
 */

print()
print(">>>>>skipWhile() Example: ")
print()

// 1. Create an observable of integers.
  Observable.of(2, 2, 3, 4, 4)

// 2. Use skip(while:...) to emitted odd element
.skip(while: { item in
    item % 2 == 0
})
.subscribe{
    print("Subscriber #1: ", $0.element ?? $0)
}
.disposed(by: disposeBag)


///ANOTHER EXAMPLE
print()
// create subject
let subj5 = PublishSubject<String>()

//add subscription with skipping 3 elements
subj5
.skip(while: { item in
    item.contains("H")
})
.subscribe{
    print("Subscriber #2: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

//add elements to subject
subj5.onNext("Hello")
subj5.onNext("Lanna")
subj5.onNext("Iam")
subj5.onNext("Hungry")
subj5.onNext("I wanna")
subj5.onNext("CHICKEN!!")

//terminate
subj5.onCompleted()



/*
 >>>>> skip(until:...)
 - Will keep skipping elements from the source observable (the one you’re subscribing to) until some other trigger observable emits.
 */

print()
print(">>>>>skipUntil() Example: ")
print()


// 1. Create a subject to model the data you want to work with,
    //and create another subject to model a trigger to change how you handle things in the first subject.
let subject1 = PublishSubject<String>()
let trigger = PublishSubject<String>()

// 2. Use skipUntil, passing the trigger subject. When trigger emits, skipUntil will stop skipping.
subject1
    .skip(until: trigger)
    .subscribe{
        print("subject #1: ", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

trigger.subscribe{
    print("trigger: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

// 3. Add some .next event to subject
    //nothing will print out (skipping)
subject1.onNext("A")
subject1.onNext("B")

//4. Add .next event to trigger.
    //Trigger emitted event => Now, subject will stop skipping
trigger.onNext("Pull trigger")


//5. Add .next event to subject. This event will be emitted as subject is no longer skipping element
subject1.onNext("C")
subject1.onNext("D")


// Taking operator (opposite from skipping)
/*
>>>>> take(Int)
 - Taking from first elements up to certain amount of elements.
 - Number of elements that need to be taken, must be declared in take()
 */
print()
print(">>>>>take() Example: ")
print()

// 1. Create an observable of integers.
Observable.of(1, 2, 3, 4, 5, 6)
    // 2. Take the first 3 elements using take.
    .take(3)
    .subscribe{
        print("observable: ", $0.element ?? $0)
    }
    .disposed(by: disposeBag)



///ANOTHER EXAMPLE
print()
// create subject
let subj6 = PublishSubject<String>()

//add elements to subject
subj6.onNext("Hello")
subj6.onNext("Lanna")
subj6.onNext("Iam")

//add subscription taking on first 2 elements
subj6
.take(2)
.subscribe{
    print("Subscriber #1: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

//add elements to subject
subj6.onNext("Hungry")
subj6.onNext("I wanna")
subj6.onNext("CHICKEN!!")

//terminate
subj6.onCompleted()


/*
>>>>> take(while: ...)
 - Taking from first elements up to certain amount of elements.
 - Number of elements that need to be taken, must be declared in take()
 */
print()
print(">>>>>takeWhile() Example: ")
print()

// 1. Create an observable of integers.
  Observable.of(2, 2, 4, 4, 6, 6)

// 2.  Use the enumerated() operator to yield tuples containing the index and element of each emitted element from an observable
.enumerated()

// 3. Use the takeWhile operator, and destructure the tuple into individual arguments.
.take(while: { index, item in
    
    //4. Pass a predicate that will take elements until the condition fails.
    item % 2 == 0 && index < 3
})
// 5. Use map (works just like the Swift Standard Library map but on observables)
    // to reach into the tuple returned from takeWhile and get the element.
.map { $0.element }

// 6. Subscribe to and print out event
.subscribe{
    print("Subscriber #1: ", $0.element ?? $0)
}
.disposed(by: disposeBag)



/*
>>>>> take(until: ...)
 - Similarly to skip(until:...)
 */
print()
print(">>>>>takeUntil() Example: ")
print()

let subject3 = PublishSubject<String>()
let trigger3 = PublishSubject<String>()

// 2. Use takeUntil, passing the trigger subject. When trigger emits, subject3 will stop taking.
subject3
    .take(until: trigger3)
    .subscribe{
        print("subject #3: ", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

trigger3.subscribe{
    print("trigger3: ", $0.element ?? $0)
}
    .disposed(by: disposeBag)

// 3. Add some .next event to subject
    //this will be printed out (taking)
subject3.onNext("A")
subject3.onNext("B")

//4. Add .next event to trigger.
    //Trigger emitted event => Now, subject will stop taking
trigger3.onNext("Pull trigger3")

//5. Add .next event to subject. Subject is skipping elements from now as trigger has emitted
subject3.onNext("C")
subject3.onNext("D")


/*
>>>>> distinctUntilChanged()
 - distinctUntilChanged only prevents duplicates that are right next to each other
 - Elements are compared for equality based on their implementation conforming to Equatable.
 */

print()
print(">>>>>distinctUntilChanged() Example: ")
print()

//EX1 : Normal Equatable Element going through .distinctUntilChanged()

// 1. Create an observable of letters.
Observable.of("A", "A", "B", "B", "A")
    // 2. Use distinctUntilChanged to prevent sequential duplicates from getting through.
    /// NOTE:  Strings conform to Equatable
    ///  However, you can provide your own custom comparing logic by using distinctUntilChanged(_:), where the externally unnamed parameter is a comparer.
    .distinctUntilChanged()
    .subscribe{
        print("subscriber #1: ", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

print()
//EX2 : Custom comparer for .distinctUntilChanged()

struct Point {
    var x: Int
    var y: Int
}

let array = [ Point(x: 0, y: 1),
                  Point(x: 0, y: 2),
                  Point(x: 1, y: 0),
                  Point(x: 1, y: 1),
                  Point(x: 1, y: 3),
                  Point(x: 2, y: 1),
                  Point(x: 2, y: 2),
                  Point(x: 0, y: 0),
                  Point(x: 3, y: 3),
                  Point(x: 0, y: 1)]

//create an observable
Observable.from(array)
      .distinctUntilChanged { (p1, p2) -> Bool in
          p1.x == p2.x // taking if 2 elements has same x-coordinator value
      }
      .subscribe(
            onNext: { point in
          print("Point (\(point.x), \(point.y))")
            },
            onCompleted: {print("Complete!")
            })
      .disposed(by: disposeBag)
 
