//: Playground - noun: a place where people can play

import Cocoa


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
