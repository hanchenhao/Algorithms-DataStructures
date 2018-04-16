# 图

在计算机术语中,图是由边(**edges**)和顶点(**vertices**)的组成的有穷集合,顶点由边互相关联,边使一个顶点链接到另一个顶点

举个例子,图可以表示一个社交网络,每个人都是一个顶点,人要了解其他的人,就要通过关联的边,才能够连接他人

图有很多不同的尺寸和形状,边可以有一个权重(**weight**),它可以在每个边上分配一个正数或者负数值,比如,我们有一个航班,每个城市就是一个顶点,飞机就是边,而边的权重就是用来描述航班的航程,以及票价,边是要有方向的,比如我们要从A到B地,这时我们要连接A到B的边,而不能是B到A

和树形的数据结构相比,图可以有环形的结构,还用上面航班的举例,我们在图的数据结构中,就可以从A到B,B到C,然后再由C回到A,树形的数据结构是做不到这样的 

通常有两种数据结构可以表示图,它们分别是邻接表(**Adjacency List**),和邻接矩阵(**Adjacency Matrix**)

### 邻接表

**邻接表**是图的一种最主要存储结构,用来描述图上的每一个点。对图的每个顶点建立一个容器（n个顶点建立n个容器），第i个容器中的结点包含顶点Vi的所有邻接顶点。邻接表是一个二维容器，第一维描述某个点，第二维描述这个点所对应的边集们。实际上我们常用的邻接矩阵就是一种未离散化每个点的边集的邻接表。

邻接表关联顶点的边大概是这样的

```swift

public struct Edge<T> {
  public let from: Vertex<T>
  public let to: Vertex<T>
  public let weight: Double
}

```
这个结构体主要包含了,从一个边到另一个边的顶点以及权重,边是有方向的,如果想联通两个方向,我们只需要再加一个边

顶点可以来这样实现

```swift
private var uniqueIDCounter = 0

public struct Vertex<T> {
  public var data: T
  public let uniqueID: Int
  
  private(set) public var edges: [Edge<T>] = []
  
  public init(data: T) {
    self.data = data
    uniqueID = uniqueIDCounter
    uniqueIDCounter += 1
  }
```

我们连接两个顶点的边可以这样

```swift

  public mutating func connectTo(destinationVertex: Vertex<T>, withWeight weight: Double = 0) {
    edges.append(Edge(from: self, to: destinationVertex, weight: weight))
  }
  
```

### 邻接矩阵

邻接矩阵的逻辑结构分为两部分：V和E集合。因此，用一个一维数组存放图中所有顶点数据；用一个二维数组存放顶点间关系（边或弧）的数据，这个二维数组称为邻接矩阵。

```swift
public struct Graph<T> {
  private var adjacencyMatrix: [[Double?]] = []
}
```


如果 `adjacencyMatrix[i][j]` 不为空,那它将代表一个边从顶点 `i` 到顶点 `j`

顶点可以这样来表示,它是矩阵中有一个独一无二的`index`

```swift
public struct Vertex<T> {
  public var data: T
  private let index: Int
}
```

要创建一个新的顶点,这个图要将矩阵扩容

```swift

struct Graph<T> {
    var adjacencyMatrix: [[Double?]] = []
    var vertices: [Vertex<T>] = []
    
    mutating func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(data: data, index: adjacencyMatrix.count)

        for i in 0..<adjacencyMatrix.count {
            adjacencyMatrix[i].append(nil)
        }
        let newRow = [Double?](repeating: nil, count: adjacencyMatrix.count + 1)
        adjacencyMatrix.append(newRow)
        vertices.append(vertex)

        return vertex
    }
}

```

我们可以通过index添加或查询对应内容

```swift

    mutating func connect(sourceVertex: Vertex<T>, to destinationVertex: Vertex<T>, withWeight weight: Double = 0) {
        adjacencyMatrix[sourceVertex.index][destinationVertex.index] = weight
    }
    
    func weightFrom(sourceVertex: Vertex<T>, toDestinationVertex: Vertex<T>) -> Double? {
        return adjacencyMatrix[sourceVertex.index][toDestinationVertex.index]
    }
    
```


