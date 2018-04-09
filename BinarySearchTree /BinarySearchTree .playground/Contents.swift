//: Playground - noun: a place where people can play


import Foundation


class BinarySearchTree<T: Comparable> {
    var value: T
    var parent: BinarySearchTree?
    var left: BinarySearchTree?
    var right: BinarySearchTree?
    
    init(value: T) {
        self.value = value
    }
    
    init(array:[T]) {
        precondition(array.count > 0)
        self.value = array.first!
        for obj in array.dropFirst() {
            insert(value: obj)
        }
    }
    
    func insert(value: T) {
        insert(value: value, parent: self)
    }
    
    private func insert(value: T, parent: BinarySearchTree) {
        if value < self.value {
            if let left = left {
                left.insert(value: value, parent: left)
            } else {
                left = BinarySearchTree(value: value)
                left?.parent = parent
            }
        } else {
            if let right = right {
                right.insert(value: value, parent: right)
            } else {
                right = BinarySearchTree(value: value)
                right?.parent = parent
            }
        }
    }
    
    func search(value: T) -> BinarySearchTree? {
        if value < self.value {
            return left?.search(value: value)
        } else if value > self.value {
            return right?.search(value: value)
        } else {
            return self
        }
    }
    
    func toArray() -> [T] {
        var arr = [T]()
        if let left = left {
            arr += left.toArray()
        }
        arr.append(value)
        if let right = right {
            arr += right.toArray()
        }
        return arr
        
    }
}


extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
    
    
}



let bst = BinarySearchTree<Int>(value: 5)

bst.insert(value: 1)
bst.insert(value: 7)
bst.insert(value: 8)
bst.insert(value: 2)
bst.insert(value: 2)

print(bst.toArray())


let bst2 = BinarySearchTree<Int>(array: [7, 2, 5, 10, 9, 1])

print("-------------")
print(bst2.toArray())


