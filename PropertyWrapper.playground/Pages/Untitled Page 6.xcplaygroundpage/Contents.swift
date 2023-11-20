//: [Previous](@previous)

import Foundation

@propertyWrapper
struct Decimal {
    
    var defaultValue: String
    
    var projectedValue = "우암마"
    
    var wrappedValue: String {
        get {
            defaultValue
        }
        set {
            let result = Int(newValue)!.formatted()
            defaultValue = "\(result)원"
            projectedValue = "\(result) 옴마야"
        }
    }
}


struct Example {
    
    var defaultValue: String
    
    var number: String {
        get {
            defaultValue
        }
        set {
            let result = Int(newValue)!.formatted()
            defaultValue = "\(result)원"
        }
    }
}

//var example = Example(defaultValue: "3원")
//example.number = "200000"
//
//example.number


struct Examples {
    
    @Decimal(defaultValue: "3")
    var number
}

var example = Examples()

example.number
example.$number
