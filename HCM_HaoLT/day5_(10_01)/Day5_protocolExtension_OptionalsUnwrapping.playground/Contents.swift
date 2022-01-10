import UIKit
import Darwin

// Day 5
/*
 - protocols, extensions, and protocol extensions
 - optionals, unwrapping, and typecasting
 */


// 1. Protocol
// - We can’t create instances of that protocol - it’s a description of what we want, rather than something we can create and use directly.

protocol Identity {
    // an id string that can be read (“get”) or written (“set”)
    var id : Int {get}
    var name : String {get set}
}
protocol DaysAbsent {
    var numOfAbsentDay : Int { get set }
    
}

protocol DepartmentName {
    var nameOfDept : String { get set }
}


// - You can inherit from multiple protocols at the same time before you add your own customizations on top. (You can only inherit 1 class)
protocol SchoolRecord : Identity,DaysAbsent,DepartmentName {
    
    var SchoolName : String { get set }

    // blueprint of a method
    func message()
    
}
//
// - We can create a struct that conforms to it
struct Student: SchoolRecord {
    func message() {
        print("School does not restrict student taking days off, but we keep the record. You have already absent \(numOfAbsentDay) days")
    }
    
    var SchoolName: String
    
    var id: Int
    
    var name: String
    
    var numOfAbsentDay: Int
    
    var nameOfDept: String
    
    var grade : Double

}
struct Teacher : SchoolRecord {
    func message() {
        print("Each teacher has 5 days off. You have \(5-numOfAbsentDay) left")
    }
    
    var SchoolName: String

    var numOfAbsentDay: Int

    var nameOfDept: String

    var id: Int
    
    var name: String
    
    var subjectTeaching: String

}


var listOfPeopleAtSchool : [SchoolRecord] =
[
    Student(SchoolName: "A", id: 0, name: "Joe", numOfAbsentDay: 5, nameOfDept: "CS", grade: 3.4),
    Teacher(SchoolName: "A", numOfAbsentDay: 1, nameOfDept: "EN", id: 1, name: "Prof Josik", subjectTeaching: "English"),
    Student(SchoolName: "A", id: 2, name: "Joe", numOfAbsentDay: 1, nameOfDept: "BUS", grade: 3.4),
    Student(SchoolName: "A", id: 3, name: "Joe", numOfAbsentDay: 2, nameOfDept: "CS", grade: 3.4),
    Teacher(SchoolName: "A,B", numOfAbsentDay: 0, nameOfDept: "ENGR", id: 3, name: "Prof Asemik", subjectTeaching: "Math"),
    Teacher(SchoolName: "C,F", numOfAbsentDay: 1, nameOfDept: "CS", id: 4, name: "Prof Josik", subjectTeaching: "C++ Programing"),
    Teacher(SchoolName: "A", numOfAbsentDay: 9, nameOfDept: "FIN", id: 5, name: "Prof Ark", subjectTeaching: "Network"),
    Student(SchoolName: "A", id: 5, name: "Joe", numOfAbsentDay: 6, nameOfDept: "ART", grade: 3.4),
    Student(SchoolName: "A", id: 7, name: "Joe", numOfAbsentDay: 0, nameOfDept: "CS", grade: 2.3)
]

var countCSMajor = 0
var countGoodStandingStudent = 0

for person in listOfPeopleAtSchool {
    if person.nameOfDept == "CS" {
        countCSMajor += 1
    }
    //Type casting:
    // - uses a keyword called as?, which returns an optional: it will be nil if the typecast failed, or a converted type otherwise.
    if let student = person as? Student {
        if (student.grade > 3.0)
        {
            countGoodStandingStudent += 1
        }
    }
    if let teacher = person as? Teacher {
        if teacher.numOfAbsentDay > 5 {
            print("\(teacher.name) from \(teacher.nameOfDept) department has taken too many day off")
        }
    }
    
}
print("There are \(countCSMajor) students and staffs in CS department")
print("There are \(countGoodStandingStudent) students who are in good academic standing")

listOfPeopleAtSchool[1].message()

listOfPeopleAtSchool[8].message()


// 2. Extension

/*
- Extension let us add functionality to classes, structs, and more, which is helpful for modifying types we don’t own or make existing types do things they weren’t originally designed to do.

- Methods added using extensions are indistinguishable from methods that were originally part of the type
- Swift doesn’t let you add stored properties in extensions, so you MUST use computed properties instead.
*/

extension Student {
    func studentAcademicStanding (){
        if self.grade < 2.0 {
            print("Needed Imporved Student")
        }
        else if self.grade < 3.0 {
            print("Average student")
        }
        else {
            print ("Good stand student")
        }
    }
}
extension Teacher {
    //computed properties
    var isExceedAllowAbsent : Bool {
        return (5-self.numOfAbsentDay) < 0
    }
}

var teacher1 = Teacher(SchoolName: "A", numOfAbsentDay: 9, nameOfDept: "CS", id: 19, name: "Prof Darn", subjectTeaching: "ART")

if (teacher1.isExceedAllowAbsent) {
    print("\(teacher1.name) has exceed number of absent days allowance")
}


/*
 - Protocol Extension
    + protocol extensions allow us to provide a default:
 */

extension Identity {
    // override default function in Identifiable protocol extension
    func identify (){
        print("My ID is \(id)")
    }
}
extension Student {
    func identify() {
        print("My student ID is \(id)")
    }
}
print("Self identify: ")

var student1 = Student(SchoolName: "A", id: 19, name: "Joey", numOfAbsentDay: 20, nameOfDept: "ART", grade: 3.4)
var teacher2 =  Teacher(SchoolName: "B", numOfAbsentDay: 7, nameOfDept: "CS", id: 43, name: "Prof Henry", subjectTeaching: "Python Development")


student1.identify() //student type
teacher2.identify() //teacher type

listOfPeopleAtSchool[1].identify() //SchoolRecord type inherit Indentifiable
listOfPeopleAtSchool[2].identify() //SchoolRecord type SchoolRecord type inherit Indentifiable


// 3. OPTIONALS & WRAPPING

// WRAP
var age : Int? = nil

func getUsername() -> String? {
    return "Joana"
}

var username = getUsername()
// UNWRAP

/*
    IF-LET:
 - A common way of unwrapping optionals is with if let syntax, which unwraps with a condition.
 - If there was a value inside the optional then you can use it, but if there wasn’t, the condition fails.
 */

//age = 90
if let myAge = age {
    print ("My age is \(myAge)")
}
else {
    print("Missing age")
}


/*
 GUARD-LET
 - guard let will unwrap an optional for you, but if it finds nil inside it expects you to exit the function, loop, or condition you used it in.
 - The major difference between if let and guard let is that your unwrapped optional remains usable after the guard code.
 */

func greet(name : String?) {
    guard let myName = name else {
        print("No name found")
        return
    }
    
    print("Hello \(myName)")
    
}
greet(name: username)


/*
 FORCING UNWRAPPING - !
 - If you know for sure that a value isn’t nil,  you can force unwrap the result by writing !
 */

let str = "30"
var num = Int(str)!
print(num)

/*
 IMPLICITLY UNWRAPPED OPTIONAL
 - Implicitly unwrapped optionals are created by adding an exclamation mark after your type name
 - You don’t need to unwrap them in order to use.
 - If you attempt to use an implicitly unwrapped optional and it’s actually nil, your code will just crash
 */
let age2 : Int! = 3
print(age2)

/*
 NIL COALESCING - ??
 - Nil coalescing lets us attempt to unwrap an optional, but provide a default value if the optional contains nil.
 => it will either be the value from inside the optional or the default value used as a backup.
 */

var mainString : String? = nil
var subString : String? = nil

//chainning NIL COALESCING
let myString = mainString ?? subString ?? "No string exist in main or sub"

print(myString)


/*
 OPTIONAL CHAINING
 */

let player : [String?] = ["Ricky", "Acer", "Molly",nil,nil]

let thirdPlayer = player [2]?.uppercased() ?? "No one"
let fourthPlayer = player[4]?.uppercased() ?? "No one"

print("3rd player: \(thirdPlayer)")
print("4th player: \(fourthPlayer)")


/*
 OPTION TRY:
 - If you want to run a function and care only that it succeeds or fails – you don’t need to distinguish between the various reasons why it might fail – then using optional try
    1) Try?
 + Changes throwing functions into functions that return an optional.
 + If the function succeeds, its return value will be an optional containing whatever you would normally have received back,
 + If it fails the return value will be an optional set to nil.
 */
enum PasswordError : Error {
    case tooSimple
    case weakPass
}

func checkPassword (pw : String) throws -> Bool {
    if pw == "123" || pw == "password" {
        throw PasswordError.tooSimple
    }
    else if (pw.count < 8) {
        throw PasswordError.weakPass
    }
    return true
    
}

var userInput : String = "HelloLalA"
    if let check = try? checkPassword(pw: userInput) {
        print("Result is \(check)")
    }
    else {
        print("This password is not good")
    }


/*
    2) Try!
 + You can use when you know for sure that the function will not fail. If the function does throw an error, your code will crash.
 */

try! checkPassword(pw: "LAlala123")
print("Password is ok")



/*
 FAILABLE INITIALIZER  - init?()
 - an initializer that might work or might not.
 - You can write these in your own structs and classes by using init?() rather than init(), and return nil if something goes wrong.

 */

struct account {
    var username : String
    var password : String
    
    //failable init with two checks:
    //    1. passwords be at least 8 characters
    //    2. not be the string “password”.

    init?(username: String, password: String) {
        guard password.count > 8 else {
            return nil
        }
        guard !password.isEmpty else {
            return nil
        }
        guard password.lowercased() != "password" else {
            return nil
        }
        
        self.username = username
        self.password = password
    }
}

var account1 = account(username: "JameBond", password: "JB")
var account2 = account(username: "Ferry", password: "")
var account3 = account(username: "Yves", password: "password")
var account4 = account(username: "Kale", password: "Kale12345")
var array = [account1,account2,account3,account4]
for acc in array {
    print ("username: \(acc?.username ?? "Nil - No name") - password: \(acc?.password ?? "Nil - No password")")
}

