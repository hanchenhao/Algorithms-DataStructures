//: Playground - noun: a place where people can play

import Cocoa
import Foundation

let numbers = [1,2,3,1,2,1,0,10,6]

func bubbleSort<T: Comparable>(array: [T]) -> [T] {
    var a  = array
    
    for i in 0..<a.count {
        for j in 1..<a.count - i {
            if a[j] > a[j-1] {
                a.swapAt(j, j-1)
            }
        }
    }
    return a
    
}

print(bubbleSort(array: numbers))

