//: Playground - noun: a place where people can play

import Cocoa

let numers = [2, 1, 5, 4, 9,312,232,123,53,4,13,123,452]


func mergeSort<T: Comparable>(array: [T]) -> [T] {
    guard array.count > 1 else {
        return array
    }
    let ave = array.count / 2
    let left = mergeSort(array: Array(array[0..<ave]))
    let right =  mergeSort(array: Array(array[ave..<array.count]))
    return merge(left: left, right: right)
}


func merge<T: Comparable>(left: [T] , right: [T]) -> [T] {
    var lIndex = 0
    var rIndex = 0
    var mArray = [T]()
    
    while lIndex < left.count && rIndex < right.count {
        if left[lIndex] > right[rIndex] {
            mArray.append(right[rIndex])
            rIndex += 1
        } else if left[lIndex] < right[rIndex] {
            mArray.append(left[lIndex])
            lIndex += 1
        } else {
            mArray.append(left[lIndex])
            lIndex += 1
            mArray.append(right[rIndex])
            rIndex += 1
        }
    }
    
    while lIndex < left.count {
        mArray.append(left[lIndex])
        lIndex += 1
    }
    
    while rIndex < right.count {
        mArray.append(right[rIndex])
        rIndex += 1
    }
    return mArray
}



print(mergeSort(array: numers))
