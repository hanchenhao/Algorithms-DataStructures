# 链表

链表是一种物理存储单元上非连续、非顺序的存储结构，数据元素的逻辑顺序是通过链表中的指针链接次序实现的。链表由一系列结点（链表中每一个元素称为结点）组成，结点可以在运行时动态生成。每个结点包括两个部分：一个是存储数据元素的数据域，另一个是存储下一个结点地址的指针域。 相比于线性表顺序结构，操作复杂。由于不必须按顺序存储，链表在插入的时候可以达到O(1)的复杂度，比另一种线性表顺序表快得多，但是查找一个节点或者访问特定编号的节点则需要O(n)的时间，而线性表和顺序表相应的时间复杂度分别是O(logn)和O(1)。

### 实现一个链表

链表由一系列的节点组成,所以我们要先去实现一个节点(**Node**),我们准备做一个双向链表,所以节点由值(**value**),前(**prev**),后(**next**)节点组成:

```swift

class Node<T> {
    var value: T
    var next: Node? = nil //下一个指向的节点
    weak var prev: Node? = nil  //上一个指向的节点
    public init(_ value: T) {
        self.value = value
    }

}
```

下面我们去实现一个基本的链表:

```swift

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
    
```

链表还应该有基本的增删改查等功能,原理都是改变节点(**Node**)的前后指向,基于这个思路,我们再完善一下:

```swift

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

```



