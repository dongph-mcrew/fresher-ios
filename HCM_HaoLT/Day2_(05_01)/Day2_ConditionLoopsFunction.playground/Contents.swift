import UIKit
import Security

// Day 2 - 05/01/2022

/*
 - operators and conditions
 - loops, loops, and more loops
 - functions, parameters, and errors
 */

//>>>> 1. operators and conditions

/*
 - Arithmetic operator : * / + %
 - Operator Overloading :
 EX: with + , we can use it to:
                        + do calculation,
                        + append string,
                        + join arrays

*/
//calculation
let num = 8
let doublenum = num + num

//append string
let substr = "hello"
let str = substr + "world"

//join arrays
let arr1 = ["Jon", "Jerry", "Jeff"]
let arr2 = ["Anne", "Arch", "Amber"]
let names = arr1 + arr2

/*
 - Comparision operator : == , != , <= , >=
 We can also make enum comparable as well:
 */
enum sizes : Comparable {
    case small  //0
    case medium //1
    case large  //2
}
let book1 = sizes.large
let book2 = sizes.small

if (book1 > book2)
{
    print("Book 1 is bigger than book 2")
}

/*
 - Conditions : if - else if - else
 */

let score = 90
if (score < 60){
    print("You fail the class")
}
else if (score < 80){
    print("You get C")
}
else if (score < 90){
    print("You get B")
}
else {
    print("You get A")
}

/*
 - Combining operators ( && || )
 && : and
 || : or
 */
let age1 = 21
let age2 = 18

// age1 AND age2  are larger than 18?
if (age1 > 18 && age2 > 18)
{
    print ("Both are over 18")
}

// age1 OR age2  are larger than 18?
if (age1 > 18 || age2 > 18)
{
    print ("At lease one is over 18")
}

/*
 - Tenary operator: condition ? True_Case : False_case
 */
print( age1 > age2 ? "Person 1 is older" : "Person 1 is younger")


/*
 - Switch Condition
 Require last case MUST be default case
 If we want to continue to the next case, we use 'fallthrough'
 */
let weather = "sunny"
switch weather {
case "rain" :
    print("Bring an umbrella")
case "cloudy" :
    print("Bring your jacket")
case "sunny" :
    print("Wear sunscreen")
    fallthrough //continue to next case
default :
    print("Have a good day!")
}


//>>>> 2. loops, loops, and more loops
/*
 Range operator (2 types) :
    + Half open range operator  ( ..> )
        up to but NOT including the last value
    + Closed range operator     ( ... )
        up to and including the last value
 */

let range1 = [1..<5] // 1,2,3,4
let range2 : CountableRange =  1..<3
let range3: CountableClosedRange = 0...3
let arr = ["Anna", "Ben", "Cindy", "Dan", "Lora"]

print(arr[range2])
print(arr[range3])

/*
 - For loop
 You can also omit the constant declaration in the for loop with an underscore,  so that Swift doesn’t create needless values:
 */
for item in arr {
    print(item)
}

//omit constant declaration
for _ in 1..<5{
    print("Play")
}

/*
 - While loop
 */
var flag = 5
while flag>3 {
    flag -= 1
}
print(flag) //=3

/*
 - Repeat loop (similar to do-while)
 */

repeat {
    flag += 1
}while (flag < 5)
print(flag) //=5

/*
 - Exitting loop:
 + exit 1 single loop - using break
 + using multiple loops:
    1. Label loop
    2. Break outter loop in inner loop
 */
// exiting single loop
while flag > 0 {
    flag -= 1
    if (flag == 3){
        print(flag)
        break
    }
}
// exiting multiple loops
var sum = 0
outerloop : for i in 1...10 {
    for x in 1...50 {
        sum += i*x
        if (sum > 10) {
            print("Sum > 10")
            break outerloop
        }
    }
}

outerloop : for i in 1...10 {
midloop: for x in 1...50 {
        sum += i*x
        for y in 1...50 {
            sum -= y
            if (sum == 5) {
                print("Sum == 5")
                break midloop
            }
        }
    }
}

/*
 - Skipping item : Use  continue -  skip the current item and continue on to the next one

 */
for i in 1...10 {
    if (i % 2 == 1) {
        continue //skip odd value
    }
    print(i) // printing only even value 2,4,6,8,19
    
}

/*
 - Infinite loop: using while true to loop until reaching a specific condition to stop looping
 */
while true {
    flag += 1
    if (flag == 10)
    {
        print("flag reach 10")
        break
    }
}
//>>>> 3. functions, parameters, and errors

//func return nothing (void function)
func sayHello () {
    print("Hello")
}

//func with parameter
func divideBy2( num : Int)
{
    print (num/2)
}

//func with return value
func isOdd(num : Int) -> Bool {
    if (num % 2 == 0) {
        return false
    }
    return true
    
}

//Skipping 'return' if function only have 1 single expression

func addNum (num1 : Int, num2 : Int) -> Int {
    num1 + num2 //no 'return' here!
}

print(addNum(num1: 5, num2: 7))

// Skipping 'return' using tenary operator

func isTaylor (name : String) -> String{
    name == "Taylor" ? "Hello Taylor"  : "Hi \(name)!"
}
print (isTaylor(name: "Hanah"))
print (isTaylor(name: "Taylor"))


//Parameter labels : external name (optional) + internal name

func call ( person: String) //1 parameter name
{
    print("Calling to " + person)
}

func talk (with person: String) //2 parameter names
{
    print("Talking with " + person)
}

call(person: "John") //call func with internal parameter's name
talk(with: "Narsh") //call func with external parameter's name


// Ommitting external name of parameter with '_' (underscore)
func greet(_ person: String) {
    print("Hello \(person)")
}
greet("John")

//default param
func sum3Num (num1 : Int = 0 , num2 : Int = 0, num3 : Int = 0)
{
    print("Sum = \(num1 + num2 + num3)")
}
sum3Num()                           //=0
sum3Num(num1: 1, num2: 2)           //=3
sum3Num(num1: 4, num2: 5, num3: 6)  //=15


//inout param
var point : Int = 5
func point2X (point : inout Int) {
    point *= 2
}
point2X(point: &point)


//Variadic function : they accept any number of parameters of the same type.
//Example : print() is Variadic function

func sayHello(to everyone: String...)
{
    for person in everyone {
        print("Hello " + person)
    }
}

sayHello(to: "John", "Nathan", "Marry", "Linda")


//>>>> 4. Handling Errors
/*
    Step 1. Write a enum define errors you want to handle.
            These MUST always be based on Swift’s existing Error type
    Step 2. Write a function that throw errors
    Step 3. Using do-try-catch to detect error in a block of code and throw error
 */

//step 1
enum PasswordErrorHandling : Error {
    case tooSimple
    case tooShort
    case emtyInput
}
//step 2
func checkPassword (_ password: String) throws -> Bool
{
    if (password.isEmpty){
        throw PasswordErrorHandling.emtyInput
    }
    if (password == "password"){
        throw PasswordErrorHandling.tooSimple
    }
    if (password.count < 8){
        throw PasswordErrorHandling.tooShort
    }
    return true
        
}
//step 3
var myPassword = "lo"

do {
    try checkPassword(myPassword)
    print("You have a good password")
}
catch { error
    print(error) // output: 'tooShort'
    switch error as! PasswordErrorHandling {
    case PasswordErrorHandling.emtyInput:
        print("Empty input")
    case PasswordErrorHandling.tooShort:
        print("Password is too short")
    case PasswordErrorHandling.tooSimple:
        print("Password is too simple")
    }
    
    
}
