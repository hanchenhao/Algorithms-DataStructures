# 双端队列

双端队列是指允许两端都可以进行入队和出队操作的队列，其元素的逻辑结构仍是线性结构。将队列的两端分别称为前端和后端，两端都可以入队和出队。他看起来,有点像船上的甲板.

通常一个基本的队列都是在队列的后端加入,然后在队列前端移除,从而实现了一个先进先出的规则.而双端队列是指允许两端都可以进行入队和出队操作的队列，其元素的逻辑结构仍是线性结构.将队列的两端分别称为前端和后端，两端都可以入队和出队.

下面我们用一个非常简单的方式去实现一个双端队列:

```swift

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

```

利用swift提供的array,我们很简单的实现了一个双端队列的基本功能,其两端都可以入队和出队.但是这个队列的效率并不是特别高,因为向头部插入和移除都会涉及申请新的内存，将已有数据迁移到新内存等内存移位操作,所以时间复杂度为 **O(n)**

## 一个更加高效的双端队列

因为`dequeue()`和`enqueueFront(_ element:T)`操作数组的头部内容,使内存移位,所以导致时间复杂度为 **O(n)**,

我们可以在创建双端队列的时候,在队列头部位置去插入一些空值来进行占位,像是这样:
```swift
[x,x,x,x,1,2,3,4,5,6,7]
```
然后,元素插入队首的时候,我们将插入的值将空值替换,比如我们在队首插入一个0,那么队列就会变成这个样子
```swift
[x,x,x,0,1,2,3,4,5,6,7]
```
现在有一块空余的空间在队首,我们删除以及插入的操作其实都是在替换对应的元素,这样我们时间复杂度就也变成了 **O(1)**

``` swift 

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
            capacity *= 2	//扩容
            
            //创建空余空间
            let emptySpace = [T?](repeating: nil, count: capacity)
            //将空余空间压入队列
            array.insert(contentsOf: emptySpace, at: 0)
            head = capacity //设置头部位置
        }
        
        head -= 1 //移位
        array[head] = element //赋值
    }
    
    public mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else { return nil }
        
        array[head] = nil
        head += 1
        
        if capacity > 10 && head >= capacity*2 { //处理冗余空间
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

```

