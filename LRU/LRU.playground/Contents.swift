//: Playground - noun: a place where people can play

import Cocoa


class Node<T> {
    var value: T
    var previous: Node<T>?
    var next: Node<T>?
    
    init(_ value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    var count = 0
    private var head: Node<T>?
    private var tail: Node<T>?
    
    func insertToHead(_ value: T) -> Node<T> {
        let node = Node(value)
        
        defer {
            count += 1
            head = node
        }
        //  没有头节点
        guard let head = head else {
            tail = node
            return node
        }
        //  有头节点
        head.previous = node
        node.previous = nil
        node.next = head
        
        return node
    }
    
    func moveToHead(_ node: Node<T>) -> Void {
        guard node !== head else { return }
        let nodeNext = node.next
        let nodePrev = node.previous
        
        nodePrev?.next = nodeNext
        nodeNext?.previous = nodePrev
        
        node.next = head
        node.previous = nil
        
        if node === tail {  //如果是尾集结点
            tail = nodePrev
        }
        
        self.head = node
    }
    
    func removeLast() -> Node<T>? {
        guard let tail = self.tail else { return nil }
        let nodePrev = tail.previous
        nodePrev?.next = nil
        self.tail = nodePrev
        
        if count == 1 {
            head = nil
        }
        count -= 1
        return tail
    }
    
}


class LRUCache<Key: Hashable , Value> {
    private struct Cache {
        let key: Key
        let value: Value
    }
    
    private let list = LinkedList<Cache>()
    private var nodes = [Key: Node<Cache>]()
    private let capacity: Int
    
    init(capacity: Int) {
        self.capacity = max(0, capacity)
    }
    
    func setValue(_ value: Value , for key: Key) -> Void {
        let payLoad = Cache(key: key, value: value)
        
        if let node = nodes[key] {  //存在
            node.value = payLoad
            list.moveToHead(node)
        } else {    //不存在
            let node = list.insertToHead(payLoad)
            nodes[key] = node
        }
        
        if list.count > capacity {
            let node = list.removeLast()
            
            if let key = node?.value.key {
                nodes[key] = nil
            }
        }
    }
    
    func getValue(for key: Key) -> Value? {
        guard let node = nodes[key] else { return nil }
        list.moveToHead(node)
        return node.value.value
    }
    
}



let cache = LRUCache<String , Any>(capacity: 3)
cache.setValue(1, for: "1") //  1
cache.setValue(2, for: "2") //  2 1
cache.setValue(3, for: "3") //  3 2 1

print(cache.getValue(for: "2") ?? "none")   //  2 3 1
cache.setValue(4, for: "4") //  4 2 3 -> 淘汰1
print(cache.getValue(for: "1") ?? "none")





