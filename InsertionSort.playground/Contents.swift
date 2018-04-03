//: Playground - noun: a place where people can play

import UIKit


func insertionSort<T>(array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    guard array.count > 1 else { return array }
    
    var a = array
    for x in 1..<a.count {
        var y = x
        let temp = a[y]
        while y > 0 && isOrderedBefore(temp, a[y - 1]) {
            a[y] = a[y - 1]
            y -= 1
        }
        a[y] = temp
    }
    return a
}

let numers = [3,2,1,4,1,2,2,9]
print(insertionSort(array: numers, >))

