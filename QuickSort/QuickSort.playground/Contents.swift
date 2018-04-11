//: Playground - noun: a place where people can play

import Cocoa

let numers = [3,2,1,4,1,2,2,9,6,10]

func quickSort<T: Comparable>(array: [T]) -> [T] {
    guard array.count > 1 else {
        return array
    }
    let a = array
    let ave = Int(a.count / 2)
    let c = array[ave]
    
    let less =  a.filter({$0 < c})
    let eq =  a.filter({$0 == c})
    let more =  a.filter({$0 > c})
    
    return quickSort(array: less) + eq + quickSort(array: more)
}

print(quickSort(array: numers))
