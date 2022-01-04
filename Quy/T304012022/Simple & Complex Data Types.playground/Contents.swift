import Cocoa

//MARK: Simple Types
//Variables
var str = "Hello World"

//String & Interger

var age = 38
var population = 8_000_000

//Multi-line String
var str1 = """
This goes
over multiple
lines
"""

var str2 = """
This goes \
over multiple \
lines
"""

//Doubles & Boolean
var pi = 3.141
var awesome = true

var myInt = 1
var myDouble = 1.0 //Swift infer that its a double by the decimal

//String Interpolation
var score = 85
var result = "Your score is \(score)"

//Constants
let taylor = "swift"

//Type Annotations
let album: String = "Reputation"
let year: Int = 2022
let height: Double = 1.88
let taylorRocks: Bool = true

//MARK: Complex Types

//Arrays
let john = "John Lenon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]
beatles[1]

//Sets
let colors = Set(["red", "green", "blue"])

let colors2 = Set(["red", "green", "blue", "red", "blue"])

var name = (first: "Taylor", last: "Swift")
name.0 + name.last

//Arrays vs Sets vs Tuples
let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")

let set = Set(["Addvark", "Astronaut", "Azalea"])

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
//Dictionaryies

let heights = [
    "Taylor Swift":1.78,
    "Ed Sheeran": 1.73
]
heights["Taylor Swift"]

//Dictionary default values
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

favoriteIceCream["Charlotte", default: "Unknown"]
//Empty Collections
var new = [String:Int]()
new["Paul"] = 20
let numbers = [Int]()

let words = Set<String>()

//Enumerations
enum Result {
    case success
    case failed
}
let result2: Result = .failed

//Enums associated values

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")

enum Conversation {
    case morning(topic: String)
    case noon(wakeUpTime: Int)
    case afternoon(atHome: Bool)
}

let morning: Conversation = .morning(topic: "Breakfast")

switch morning {
case .morning(topic: let string):
    string
case .afternoon(atHome: let bool):
    bool
case .noon(wakeUpTime: let hour):
    hour
}

if case let .morning(str) = morning {
    str
}

//Enum raw values

enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 3)

//MARK: Enums & equatable
enum Times: Equatable {
    case second (Int)
    case minute (Int)
    case hour (Int)
}

let time1 = Times.second(20)
let time2 = Times.second(15)

if time1 == time2 {
    print("Matched")
}


