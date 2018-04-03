# 队列

队列的本质是一个数组，但只能从队尾添加元素，从队首移除元素。这保证了第一个入队的元素总是第一个出队。先到先得！

有什么使用场景呢? 比如我们排队买票,总要设置一个公平的规则,让先来的人先得到票.在很多算法的实现中，你可能需要将某些对象放到一个临时的列表中，之后再将其取出。通常加入和取出元素的顺序非常重要。

队列和栈有些不一样,队列可以保证元素存入和取出的顺序是先进先出(first-in first-out, FIFO)的，第一个入队的元素总是第一个出队，公平合理！栈，它是一个后进先出(last-in, first-out, LIFO)的结构。

下面用swift来实现一个基本的队列.

``` swift

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

```

上面实现的队列只是可以正常工作，入队操作的时间复杂度为 O(1)，因为在数组的尾部添加元素只需要固定的时间，跟数组的大小无关.因为在 Swift 的内部实现中，数组的尾部总是有一些预设的空间可供使用.举个例子:

``` swift
	var queue = Queue<String>()
	queue.enqueue("a")
	queue.enqueue("b")
	queue.enqueue("c")
```
我们向队列插入若干条数据,实际上数组的空间可能是下面这个样子的:
``` swift
	["a","b","c","xxx"]
```
xxx代表已经申请,但是还未使用的内存,再尾部插入一个元素就会使用到这个未被使用的内存.所以,简单的拷贝内存的工作，只需要固定的常量时间.

当然，数组尾部的未使用内存的大小是有限的，如果最后一块未使用内存也被占用的时候，再添加元素会使得数组重新调整大小来获取更多的空间,这时候,重新调整的过程包括申请新的内存，将已有数据迁移到新内存中,这个操作的时间复杂度是 O(n).实际开发过程中,这种情况并不常见，所以，这个操作的时间复杂度依然是 O(1) 的，或者说是近似 O(1) 的.

但是出队列的操作是将数组头部元素移除,以为这回导致内存移位的操作,所以这个操作时间复杂度是O(n).

### 一个更加高效的队列
为了让队列的出列更加高效,我们可以使用入队类似的技巧,也就是在**队首**保留一些额外的内存空间,因为swift并没有提供这种机制,所以我们要手动修改一下:
``` swift
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
	        array[head] = nil
	        head += 1
	        return element
	    }
	    
	    func peek() -> T? {
	        return array.isEmpty ? nil : array[head]
	    }
    
}
```

上述代码简单的实现了一个出队列不操作内存移位,而用空值来进行头部的占位.
针对 `dequeue()` 函数，在将队首元素出队时，我们首先将 `array[head]` 设置为 `nil` 来将这个元素从数组中移除。然后将 `head` 的值加一，使得下一个元素变成新的队首。

但是,如果我们从不移除队首的空位，随着不断地入队和出队，队列所占空间将不断增长。为了周期性地清理无用空间,我们将上面的代码再优化一下:
``` swift 
	    mutating func dequeue() -> T? {
        guard head > array.count , let element = array[head] else {
            return nil
        }
        array[head] = nil
        head += 1
        
        let capacity = 50   //数组的容量
        let persect = 0.2   //阈值
        
        //  数组容量过大,或超过头部所占空间的阈值 , 使用原始出列方式以节约空间
        if array.count > capacity , Double(head) / Double(array.count) > persect {
            array.removeFirst()
            head = 0
        }
        return element
    }
```
当队列的数组超过我们设定的阈值,我们将使用原始的方式移除首部元素,以重新排列内存,因为移除的操作并不会很频繁,所以现在出队操作的复杂度已经从当初的 O(n) 变为了现在的 O(1).






