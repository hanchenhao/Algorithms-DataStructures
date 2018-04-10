//: Playground - noun: a place where people can play

import Cocoa
import Foundation


func insertionSort<T: Comparable>(array: [T] , _ compare:(T,T) -> Bool) -> [T] {
    var a = array
    
    for i in 1..<a.count {
        var n = i
        while n > 0 && compare(a[n] , a[n-1]) {
            a.swapAt(n, n-1)
            n -= 1
        }
    }
    return a
}


let numbers = [1,23,2,5,1,2,4,10]

print(insertionSort(array: numbers, <))

