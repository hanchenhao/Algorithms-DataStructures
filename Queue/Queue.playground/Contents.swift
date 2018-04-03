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

var queue = Queue<String>()
queue.enqueue("a")
queue.enqueue("b")
queue.enqueue("c")
print(queue.array)

struct FastQueue<T> {
    var array = [T?]()
    private var head = 0

    mutating func enqueue(_ element: T) {
        array.append(element)
    }

    mutating func dequeue() -> T? {
        guard head > array.count , let element = array[head] else {
            return nil
        }
        let capacity = 50   //数组的容量
        let persect = 0.2   //阈值
        array[head] = nil
        head += 1
        
        //  数组容量过大,或超过头部所占空间的阈值 , 使用原始出列方式以节约空间
        if array.count > capacity , Double(head) / Double(array.count) > persect {
            array.removeFirst()
            head = 0
        }
        return element
    }

    func peek() -> T? {
        return array.isEmpty ? nil : array[head]
    }

}

var q = FastQueue<String>()
q.enqueue("a")
q.enqueue("b")
q.enqueue("c")
q.enqueue("d")
q.enqueue("e")
q.enqueue("f")
q.enqueue("g")
print(q.array)
q.dequeue()
print(q.array)



