//: [Previous](@previous)

import Foundation


//print("김규철")

// main - serial

//DispatchQueue.main.async {
//    for i in 1...100 {
//        print(i, terminator: " ")
//    }
//}
//
//for i in 101...200 {
//    print(i, terminator: " ")
//}
//
//print("BYE")

print("김규철")

for i in 1...100 {
    DispatchQueue.global().async {
        print(i, terminator: " ")
    }
}

for i in 101...200 {
    print(i, terminator: " ")
}

print("BYE")


