import UIKit

//Day 3
//- closures
//- structs, properties, and methods (PART 1 + 2)


/*
>>>>>>>>>>> CLOSURE:
 - Creates a function without a name, and assigns that function to a variable. And even pass that function into other functions as parameters.

 */


let sayHello = {
    print("Hello!")
}
sayHello()


// Closure with parameter
// + Place parameters inside { }
// + After 'in' is where closure's main body start

let sayHello2 = { (name : String) in
    print("Hello \(name)!")
}
sayHello2("Jane")


// Return value in Closure
// + Similar to function, return value with 'return'

let sayHello3 = { (name : String) in
    return "Hello \(name)!"
}

let saying = sayHello3("Jay")
print(saying)

//1. Closure as function's parameter

// + specify the parameter type as () -> Void.  Meaning accepts no parameters, and returns Void

func tourist(person: String , action: () -> Void)
{
    print("\(person) goes to places, and says:")
    action()
    print("Now, \(person) returns home")
}

tourist(person: "Joe",action: sayHello)

//This is trailing closure syntax
tourist(person: "Jeff") {
    sayHello()
}


//2. Closure with Parameters as function's parameter
func tourist2(person: String , action: (String) -> Void)
{
    print("\(person) goes to places, and says:")
    action("people")
    print("Now, \(person) returns home")
}

tourist2(person: "Jim") { p in
    sayHello2("everyone")
}

//tourist2(person: "Jim") { p in
//    print("Hello everyone!!")
//}
//


//2. Closure with Parameters & Returns values as function's parameter

func tourist3(person: String , action: (String) -> String)
{
    print("\(person) goes to places, and says:")
    let saying = action("people")
    print(saying)
    print("Now, \(person) returns home")
}

tourist3(person: "Jeremy") { (person : String) -> String in
    sayHello3("everybody")
}

// More example:
//  + Add up all numbers in an array

func findTotal(values : [Int], addUp: (Int,Int) -> Int) -> Int {
    
    var currentSum  = values[0] //init sum = 1st item's value
    
    //loop from 2nd item to the end of array
    for next_item in values[1...] {
        currentSum = addUp(currentSum,next_item)
    }
    
    return currentSum
}

let numbers = [10,11,12,13,14,15,16]

let sum = findTotal(values: numbers) { previousTotal, nextValue in
    
//    return previousTotal + nextValue
    //because there is only 1 line, we can just write:
    previousTotal + nextValue
}

print("Total is : \(sum)")

//shorthand parameter name style

let sum2 = findTotal(values: numbers) {
    $0 + $1  // automatic name - $0 for 1st param of closure
             // automatic name - $1 for 2nd param of closure
             // only 1 line expression => don't need to write 'return'
}
print("Total is : \(sum2)")


//3. Return closure from function

// Example: We will have a function that:
//  + accepts 1 parameters, and returns a closure.
//  + The closure that gets returned must be called with a string, and will return nothing.
func tourist4(person: String) -> (String)-> Void
{
    print("\(person) visit different places")
    
    //return closure
    return {
        print("\($0) says: Hello mate!")
    }
}

let getClosure = tourist4(person: "Joey") // return a closure
getClosure("Jerry") // call closure as normal function


// 5. CLosure capturing
// + Closure capturing happens if we create values in travel() that get used inside the closure.
// + it gets captured by the closure so it will still remain alive for that closure.

func tourist5(person: String) -> (String) -> Void {
    var counter = 0
    print("\(person) visit different places")
    return {
        counter += 1
        print("\(person) says Hello to \($0) \(counter) times")
    
    }
}

let result2 = tourist5(person: "Jack") //print 1st line + return closure
result2("Jury") // counter = 1
result2("Jury") // counter = 2
result2("Jury") // counter = 3


/*
>>>>>>>>>>> STRUCT:
 - Creates a function without a name, and assigns that function to a variable. And even pass that function into other functions as parameters.

 */
struct School {
   
    var name : String
    
    //static property: share specific properties and methods across all instances of the struct by declaring them as static.
    static var totalStudent : Int = 0
    
    //custom initializer
    init(){
        name = "School A"
        print("Student is from School A")
        School.totalStudent += 1 //keep track of number of students
    }
}
struct Student {
    
    //Acess control
    // - private: lets you restrict which code can use properties and methods.
    //   + can’t read/modify it from outside the struct
    //   + must use struct's method to read/modify value of private property
    
    private var id: Int
    
    //Stored properties
    var name : String
    
    var gpa : Double {
        //property observer (didSet) -  let you run code before or after any property changes.
        didSet {
            print("Student ID \(id), GPA changes")
        }
    }
    var isMale : Bool
    
    //Computed property :  runs code to figure out its value
    // + the value is recomputed every time it’s called
    // + use when your property’s value relies on the values of your other properties
    var academicStanding : String {
        if (gpa < 2.0){
            return "under supervision"
        }
        else if (gpa < 3.0) {
            return "good standing"
        }
        else {
            return "exellent standing"
        }
    }
    
    //Lazy property:
    // + Delay the creation of a property until it’s actually used (like a computed property)
    // + Unlike a computed property they store the result that gets calculated, so that subsequent accesses to the property don’t redo the work
    var schoolName = School()
    
    // struct's methods
    func studentInfo() -> String {
        return "Student ID: \(id) - \(name) has GPA: \(gpa), which is \(academicStanding)"
    }
    
    func getStudentID() -> Int {
        return self.id
    }
    
    // mutating method - When you want to change a property inside a method, you need to mark it using the 'mutating' keyword
    mutating func changeName(name: String) {
       //Referring to current instance ( SELF )
        self.name = name //modify 'name'
    }
    
    mutating func changeStudentID(id : Int){
        self.id = id
    }
 
}
extension Student{
    //Custom initializer
    //By putting init() inside extension, we can have both
        //custom initializer &  default memberwise initializer options when create 'student' instances
    init() {
        self.id = School.totalStudent
        self.name = "Anonymous"
        self.isMale = true
        self.gpa = 0.0
    }
}

//default memberwise initializer
//let student1 = Student(id: School.totalStudent, name: "Bob", gpa: 3.0, isMale: true)

//custom initializer
var student1 = Student()
var student2 = Student()

student1.changeName(name: "Archie")
student1.gpa = 4.0
student2.changeName(name: "Larry")

var info1 = student1.studentInfo()
var info2 = student2.studentInfo()
print(info1)
print(info2)
print("Total student in the school : \(School.totalStudent)") //total = 2 as we created 2 students which has School as its property
