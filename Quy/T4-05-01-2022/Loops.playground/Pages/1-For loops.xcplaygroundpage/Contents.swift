import Cocoa

 
/*
 For loops are loops that can loops through array and ranges, for loop can make constant using the element pulled from the array or ranges with each loop
 */
let range = 1...10

//Looping through a range
for number in range {
    print(number)
}

//Looping through an array
let albums = ["Red", "1989", "Reputation"]

for album in albums {
    print(album)
}
//Looping without constant
print("Player gonna play")

for _ in 1...5 {
    print("Play")
}

