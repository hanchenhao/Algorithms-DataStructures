//: Playground - noun: a place where people can play

import UIKit

struct Queue<T> {
    var array = [T]()
    //  入队列
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    //  出队列
    mutating func dequeue() -> T?{
        return array.isEmpty ? nil : array.removeFirst()
    }
    //  获取队列首元素
    func peek() -> T? {
        return array.first
    }
}

var queue = Queue(array: ["a","b","c"])
print(queue.peek() ?? "none")
queue.enqueue("d")
print(queue.peek() ?? "none")
queue.dequeue()
print(queue.peek() ?? "none")


