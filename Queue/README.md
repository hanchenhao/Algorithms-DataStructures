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



