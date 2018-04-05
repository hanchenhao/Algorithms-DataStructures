//: Playground - noun: a place where people can play


import Foundation

struct Deque<T> {
    
    var array = [T]()
    
    var isEmpty:Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    mutating func enqueue(_ element:T) {
        array.append(element)
    }
    
    mutating func enqueueFront(_ element:T) {
        array.insert(element, at: 0)
    }
    
    mutating func dequeue() -> T? {
        return isEmpty ? nil : array.removeFirst()
    }
    
    mutating func dequeueBack() -> T? {
        return isEmpty ? nil : array.removeLast()
    }
    
    func peekFront() -> T? {
        return array.first
    }
    
    func peekBack() -> T? {
        return array.first
    }
}


public struct DequeOptimized<T> {
    private var array: [T?]
    private var head: Int
    private var capacity: Int
    
    init(capacity: Int = 10) {
        self.capacity = max(capacity, 1)
        array = [T?].init(repeating: nil, count: capacity)
        head = capacity
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var count: Int {
        return array.count - head
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func enqueueFront(_ element: T) {
        if head == 0 {  //如果首部位置为0,则没有空余空间,应该分配一定的空置空间给队列
            capacity *= 2
            let emptySpace = [T?](repeating: nil, count: capacity)
            array.insert(contentsOf: emptySpace, at: 0)
            head = capacity
        }
        
        head -= 1
        array[head] = element
    }
    
    public mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else { return nil }
        
        array[head] = nil
        head += 1
        
        if capacity > 20 && head >= capacity*2 {
            let amountToRemove = capacity + capacity/2
            array.removeFirst(amountToRemove)
            head -= amountToRemove
            capacity /= 2
        }
        return element
    }
    
    public mutating func dequeueBack() -> T? {
        
        return isEmpty ? nil : array.removeLast()
        
    }
    
    public func peekFront() -> T? {
        
        return isEmpty ? nil : array[head]
        
    }
    
    public func peekBack() -> T? {
        
        return isEmpty ? nil : array.last ?? nil
        
    }
}

var opDeque = DequeOptimized<Int>(capacity: 10)
opDeque.enqueueFront(1)
opDeque.enqueue(2)
opDeque.enqueue(3)
opDeque.enqueue(4)
opDeque.enqueueFront(5)

print(opDeque.count)
print(opDeque.peekFront() ?? "")
