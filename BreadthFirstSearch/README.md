# 广度(宽度)优先搜索

广度优先搜索算法（**Breadth First Search**）是最简便的图的搜索算法之一，这一算法也是很多重要的图的算法的原型。**Dijkstra单源最短路径算法**和**Prim最小生成树算法**都采用了和广度优先搜索类似的思想。其别名又叫**BFS**，属于一种盲目搜寻法，目的是系统地展开并检查图中的所有节点，以找寻结果。换句话说，它并不考虑结果的可能位置，彻底地搜索整张图，直到找到结果为止。

**BFS**是从根节点开始,沿着树或图的宽度遍历节点,如果所有的节点均被访问,则算法终止

**BFS**每次搜索指定节点,并将其所有未访问过的邻接点加入搜索队列,循环搜索过程直到队列为空

**广度优先搜索**首先我们需要借助一个树或者图的数据结构,并利用队列来进行搜索

下面我们来写一个`Graph`和`Queue`

`Graph`需要节点(`Node`)以及边(`Edge`)

```swift


class Edge: Equatable {

    var neighbor: Node
    
    init(_ neighbor: Node) {
        self.neighbor = neighbor
    }
    
    static func == (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.neighbor == rhs.neighbor
    }
}


class Node: Equatable {
    
    var neighbors: [Edge]
    var label: String
    var visited: Bool
    var distance: Int?
    
    init(_ label: String) {
        neighbors = []
        self.label = label
        visited = false
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.neighbors == rhs.neighbors && lhs.label == rhs.label
    }
}

class Graph: Equatable {
    
    var nodes: [Node]
    
    init() {
        self.nodes = []
    }
    
    func addNode(_ label: String) -> Node {
        let node = Node(label)
        nodes.append(node)
        return node
    }
    
    func addEdge(_ source: Node , neighbor: Node) -> Void {
        source.neighbors.append(Edge(neighbor))
    }
    
    static func == (lhs: Graph, rhs: Graph) -> Bool {
        return lhs.nodes == rhs.nodes
    }
}

```

我们给Graph插入一些测试数据,它将形成一个这样形状的结构

```
		      a
		     / \
		  b   c
		 / \ / \ 
	        d  e-f-g
	          / 
	         h

```

当我们用广度优先搜索的时候,算法将让它将沿着a-b-c-d-e-f-g-h 这样一个路线进行搜索

要实现这个算法,我们可以借助队列来完成,队列我们暂时先不考虑性能,利用数组做一个最基础的先进先出的`Queue`

```swift

class Queue<T> {
    private var array: [T]
    
    init() {
        self.array = []
    }
    
    func enqueue(_ element: T) -> Void {
        array.append(element)
    }
    
    func dequeue() -> T? {
        return array.isEmpty ?  nil : array.removeFirst()
    }
    
    func peek() -> T? {
        return array.first
    }
}

```

广度优先搜索的原理是利用循环配合队列来遍历Graph的每一层,从而打到查询的目的,在这里我们需要标记我们的节点是否被访问过,被访问过的节点,我们将不再重复进行查询

```swift

func breadthFirstSearch(_ graph: Graph, source: Node) -> [String] {
    let queue = Queue<Node>()
    queue.enqueue(source)
    var nodesExplored = [source.label]
    source.visited = true

    while let node = queue.dequeue() {
        for edge in node.neighbors {
            let neighborNode = edge.neighbor
            if !neighborNode.visited {
                queue.enqueue(neighborNode)
                neighborNode.visited = true
                nodesExplored.append(neighborNode.label)
            }
        }
    }
    
    return nodesExplored
}

```

我们测试一下

```swift	

let graph = Graph()

let nodeA = graph.addNode("a")
let nodeB = graph.addNode("b")
let nodeC = graph.addNode("c")
let nodeD = graph.addNode("d")
let nodeE = graph.addNode("e")
let nodeF = graph.addNode("f")
let nodeG = graph.addNode("g")
let nodeH = graph.addNode("h")

graph.addEdge(nodeA, neighbor: nodeB)
graph.addEdge(nodeA, neighbor: nodeC)
graph.addEdge(nodeB, neighbor: nodeD)
graph.addEdge(nodeB, neighbor: nodeE)
graph.addEdge(nodeC, neighbor: nodeF)
graph.addEdge(nodeC, neighbor: nodeG)
graph.addEdge(nodeE, neighbor: nodeH)
graph.addEdge(nodeE, neighbor: nodeF)
graph.addEdge(nodeF, neighbor: nodeG)

let nodesExplored = breadthFirstSearch(graph, source: nodeA)
print(nodesExplored)

```

最终的结果为

>["a", "b", "c", "d", "e", "f", "g", "h"]


