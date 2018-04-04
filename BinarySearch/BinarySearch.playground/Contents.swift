//: Playground - noun: a place where people can play

import Foundation

extension Array {
    
    func linearSearch<T: Equatable>( key: T) -> Int? {
        
        guard let array: [T] = self as? [T] else {
            return nil
        }
        
        for i in 0 ..< array.count {
            if array[i] == key {
                return i
            }
        }
        return nil
    }
    
    
    func binarySearch<T: Comparable>(key: T) -> Int? {
        guard let array: [T] = self as? [T] else {
            return nil
        }
        var low = 0
        var upper = array.count
        while low < upper {
            let mid = low + (upper - low) / 2
            if array[mid] == key {  //  查到结果
                return mid
            } else if array[mid] > key {    //  待查结果比当前结果小,在左边部分
                upper = mid
            } else {    //  待查结果比当前结果大,在右边部分
                low = mid + 1
            }
        }
        
        return nil
    }
    
}

let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]

print(numbers.binarySearch(key: 2) ?? "none")

