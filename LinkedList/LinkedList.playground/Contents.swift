//: Playground - noun: a place where people can play


import Foundation

// 节点
class Node<T> {
    var value: T
    var next: Node? = nil //下一个指向的节点
    weak var prev: Node? = nil  //上一个指向的节点
    public init(_ value: T) {
        self.value = value
    }
    
}

//  链表
class LinkedList<T> {
    
    private var head: Node<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: Node<T>? {
        return head
    }
    
    var last: Node<T>? {
        if var node = head {
            while let next = node.next {
                node = next
            }
            return node
        }
        return nil
    }
    
    var count: Int {
        if var node = head {
            var nodeCount = 1
            while let next = node.next {
                node = next
                nodeCount += 1
            }
            return nodeCount
        }
        return 0
    }
    
    
    func append(_ value: T) -> Void {
        let newNode = Node(value)
        if let lastNode = last {
            newNode.prev = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
        
    }
    
    func nodeAtIndex(index: Int) -> Node<T>? {
        var node = head
        if index >= 0 {
            var count = index
            while count > 0 {
                node = node?.next
                count -= 1
            }
            return node
        }
        return head
    }
    
    
    func subScript(index: Int) -> T? {
        if let value = nodeAtIndex(index: index)?.value {
            return value
        }
        return nil
        
    }
    
    func nodesBeforeAndAfter(index: Int) -> (Node<T>? , Node<T>?) {
        let node = nodeAtIndex(index: index)
        return (node?.prev , node?.next )
        
    }
    
    func insert(value: T, atIndex index: Int) -> Void {
        if index >= count  , index < 0{ //   索引错误
            print("index error")
            return
        }
        let (before, _) = nodesBeforeAndAfter(index: index)
        let node = nodeAtIndex(index: index)
        
        let newNode = Node<T>(value)
        newNode.next = node
        newNode.prev = before
        before?.next = newNode
        
        if before == nil {
            head = newNode
        }
    }
    
    
    func replace(value: T, atIndex index: Int) -> Void {
        if index >= count , index < 0 { //   索引错误
            print("index error")
            return
        }
        let (before, after) = nodesBeforeAndAfter(index: index)
        
        let newNode = Node<T>(value)
        newNode.next = after
        newNode.prev = before
        before?.next = newNode
        after?.prev = newNode
        if before == nil {
            head = newNode
        }
    }
    
    func printNode() -> Void {
        var node = head
        while node != nil {
            print(node?.value ?? "none")
            node = node?.next
        }
    }
    
    func removeAll() -> Void {
        head = nil
    }
    
    func remove(node: Node<T>) -> Void {
        let prev = node.prev
        let next = node.next
        if prev != nil {
            prev?.next = next
        }
        next?.prev = prev
        node.prev = nil
        node.next = nil
        
    }
    
    func remove(index: Int) -> Void {
        guard let node = nodeAtIndex(index: index) else {
            return
        }
        remove(node: node)
        
    }
}


let node = LinkedList<Int>()
node.append(1)
node.append(2)
node.append(3)
node.append(4)

node.printNode()
print("node last:")
print(node.last?.value ?? "none")
print("node index 2:")
print(node.nodeAtIndex(index: 2)?.value ?? "none")
print("node before & after 2:")
let (before, after) = node.nodesBeforeAndAfter(index: 2)
print("node before:")
print(before?.value ?? "none")
print("node after:")
print(after?.value ?? "none")

node.insert(value: 0, atIndex: 2)
print("-----------")
node.printNode()

node.replace(value: 10, atIndex: 2)
print("-----------")
node.printNode()

node.remove(index: 4)
print("-----------")
node.printNode()

print("------------")
print(node.subScript(index: 1) ?? "")
