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
