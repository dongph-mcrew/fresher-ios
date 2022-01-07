import UIKit

//Day 4
//Classes & Inheritance


/*
 Class:
 - Not come with memberwise initializer, we need to create our init()
 - Can be built upon another class, and gaining its properties & methods (inheritance trait)
    + 1 class can only inherit 1 other class
 - Copies of classes point to same shared data
 - Have deinitializer (called when instance is destroyed)
 - Don't need 'mutating' keyowrd, properties can be modified freely

 */


// Parent class
class Person {
    
    var gender : String
    
    static var countPeople : Int = 0 //global var, keep track of the total
    
    init(gender : String) {
        self.gender = gender
        Person.countPeople += 1
    }
    init() {
        self.gender = "Undefined"
        Person.countPeople += 1
    }
    
    //methods
    func wakeUp() {
        print("I normally wake up at 9AM")
    }
    
    deinit {
        print("This person is no longer alive")
    }
}

//Child class

// + 'Employee' is inherited from Person
// + 'Employee' is also a final class which no other class can inherit from it
final class Employee : Person {
    
    let id : Int
    var name : String
    var position : String
    
    
    init(name : String , position : String, gender : String )
    {
        self.name = name
        self.position = position
        self.id = Person.countPeople //canot be changed afterward as it is a constant
        
        super.init(gender: gender)
    }
    
    init(name: String , position : String){
        self.name = name
        self.position = position
        self.id = Person.countPeople//canot be changed afterward as it is a constant
        
        super.init() // create with undefined-gender Person
    }
    
    //overiding method :  Child classes can replace parent methods with their own implementations
    override func wakeUp() {
        print("I wake up early at 7AM to go to work")
    }
    
    //Deinitializer - code that gets run when an instance of a class is destroyed.
    deinit {
        print("This employee is no longer alive")
    }
    
}

var person1 = Person(gender: "Male")
var person2 = Person()

person1.wakeUp()
print("Person 2 gender is \(person2.gender)")
      
var employee1 = Employee(name: "Jane", position: "Saler")
var employee2 = Employee(name: "Acer", position: "Accountant", gender: "Male")

//Copying objects : When you copy a class, both the original and the copy point to the same thing, so changing one does change the other.
var jane = employee1
var acer = employee2

jane.gender = "Femal"
acer.position = "Assistant"

jane.wakeUp()

print("\(jane.name) is \(jane.gender). Position: \(jane.position)")

print("\(acer.name) is \(acer.gender). Position: \(acer.position)")


//mutability:
// as long as the property is declared as a 'var', you can modify the value even if the class instance is a constant

//This is a
let eric = Employee(name: "Eric", position: "Director", gender: "Male")
eric.name = "Erik"
eric.position = "Senior Director"
//eric.id = 15 CANNOT modify because it's a let property


print("Employee: \(eric.name), ID: \(eric.id), gender: \(eric.gender), position: \(eric.position)")

print("Total people: \(Person.countPeople)") // static var


struct ExecutiveBoard {
    static var totalMem = 0
    var member : Employee
    init(member : Employee){
        self.member = member
        ExecutiveBoard.totalMem += 1
    }
}

var eb1 = ExecutiveBoard(member: eric)
var eb2 = ExecutiveBoard(member: acer)

print("Total memeber on executive board: \(ExecutiveBoard.totalMem)") // static var


