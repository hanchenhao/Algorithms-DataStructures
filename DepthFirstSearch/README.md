# 深度优先搜索

深度优先搜索(**Depth-First Search**)，是图论中的经典算法。其利用深度优先搜索算法可以产生目标图的相应拓扑排序表，利用拓扑排序表可以方便的解决很多相关的图论问题，如最大路径问题等等。

图的深度优先遍历类似于树的前序遍历。采用的搜索方法的特点是尽可能先对纵深方向进行搜索。这种搜索方法称为深度优先搜索(**Depth-First Search**)。相应地，用此方法遍历图就很自然地称之为图的深度优先遍历。

完成深度优先搜索算法,我们要借助图和递归来实现

首先我们实现一个`Graph`

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

我们给Graph插入一些测试数据,让其形成一个这样的结构

```
		      a
		     / \
		  b   c
		 / \ / \ 
	        d  e-f-g
	          / 
	         h

```

当我们用深度优先搜索,它将沿着a-b-d-e-h-f-g-c 这样一个路线进行搜索

要实现这个算法,我们可以用基本的递归方式来完成

```swift

func depthFirstSearch(_ graph: Graph, source: Node) -> [String] {
    var nodesExplored = [source.label]
    source.visited = true
    
    for edge in source.neighbors {
        if !edge.neighbor.visited {
            nodesExplored += depthFirstSearch(graph, source: edge.neighbor)
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

let nodesExplored = depthFirstSearch(graph, source: nodeA)
print(nodesExplored)

```

最终的结果为

>["a", "b", "d", "e", "h", "f", "g", "c"]

