# Cache LRU

## 缓存淘汰算法

![](https://marcosantadev.com/wp-content/uploads/CacheLRU.jpg)

>**LRU**（Least recently used）算法根据数据的历史访问记录来进行淘汰数据，其核心思想是如果数据最近被访问过，那么将来被访问的几率也更高。

Cache LRU 和字典很相似。通过 Key-Value 的方式存储。字典和 Cache 之间的区别在于后者的容量有限。每次达到容量时，Cache都会删除最近最少使用的数据。

### Cache LRU 实现过程

下面我们首先实现一个双向链表,其应该包含头节点,末端节点和数量

```swift

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

}

```

下面我们梳理一下这个链表存储和删除数据的过程,其中存储的数据有两种情况,其分别是已存在的数据和新数据:

1. 当数据存储,这个数据为新数据时,我们将这个数据插入到链表的头节点
2. 当数据存储,这个数据为已存在数据时,我们要分别改变其对应前后节点的指向,并将其移动到头节点
3. 当删除数据时,我们将移除末端节点

```swift

    func insertToHead(_ value: T) -> Node<T> {
        let node = Node(value)
        
        defer {
            count += 1
            head = node
        }

        guard let head = head else {
            tail = node
            return node
        }

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
        
        if node === tail {  
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

```

淘汰算法的核心实现思路是利用双向链表,我们将每次访问过的值放到链表的最前端(加权),当数据超过我们预定容量的时候,我们将链表的末端节点移除,在这里选中链表而不是两端队列的原因是在向首端插入数据的时候,链表的性能更好,可以直接节点的只向来进行定位,而队列可能会产生内存偏移

针对这个思路,我们将缓存包装成和字典(`Dictionary`)类似的 Key-Value 结构,通过它的`setter`和`getter`进行加权以及移除


```swift

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


```

### Cache LRU 测试结果

我们插入一些数据来测试一下算法是否可以成功淘汰数据

```

let cache = LRUCache<String , Any>(capacity: 3)
cache.setValue(1, for: "1") //  1
cache.setValue(2, for: "2") //  2 1
cache.setValue(3, for: "3") //  3 2 1

print(cache.getValue(for: "2") ?? "none")   //  2 3 1
cache.setValue(4, for: "4") //  4 2 3 -> 淘汰1
print(cache.getValue(for: "1") ?? "none")

```
最终的结果为

>2
>none




