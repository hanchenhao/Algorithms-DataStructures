# 优先队列

优先队列是一个保证最重要的元素永远棑在最前面的队列.
优先队列中，元素被赋予优先级。当访问元素时，具有最高优先级的元素最先删除。优先队列具有最高级先出 （first in, largest out）的行为特征。
优先队列可以设置这个队列的最大权重(**max-priority**)或最小权重(**min-priority**)以保证在队列中的位置在前或者靠后.

### 优先队列的使用场景

优先队列是一种非常有用的数据结构,它可以保证在优先队列中，优先级高的元素先出队列.如果定义好最重要的元素,在很多数据处理的时候就不用反复确认哪个数据的权重大或者小.

#### 优先队列的优势

1. 模拟一个时间驱动,每个事件给出一个时间戳和你想要的事件是在其时间戳顺序执行。优先级队列可以很容易地找到需要模拟的下一个事件
2. 图搜索Dijkstra的算法使用一个优先队列计算最小成本。
3. 用于数据压缩,生成压缩树。它总是需要找到两个具有最小频率的节点，这些节点还没有父节点,这个时候优先级就会起到很大的作用.

### 实现一个优先队列

我们用堆(**heap**)来实现这个队列,因为堆本身就是优先队列的数据结构,堆比排序数组的性能更高,堆的时间复杂度仅为 O（log n）

``` swift

public struct PriorityQueue<T> {
  private var heap: Heap<T>

  public init(sort: (T, T) -> Bool) {
    heap = Heap(sort: sort)
  }

  public var isEmpty: Bool {
    return heap.isEmpty
  }

  public var count: Int {
    return heap.count
  }

  public func peek() -> T? {
    return heap.peek()
  }

  public mutating func enqueue(element: T) {
    heap.insert(element)
  }

  public mutating func dequeue() -> T? {
    return heap.remove()
  }

  public mutating func changePriority(index i: Int, value: T) {
    return heap.replace(index: i, value: value)
  }
}

extension PriorityQueue where T: Equatable {
  public func indexOf(element: T) -> Int? {
    return heap.indexOf(element)
  }
}

```


