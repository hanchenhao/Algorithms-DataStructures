//: Playground - noun: a place where people can play

import Cocoa

//  顶点
struct Vertex<T> {
    var data: T
    let index: Int
}

//  图 => 邻接矩阵 , 顶点集合
struct Graph<T> {
    var adjacencyMatrix: [[Double?]] = []
    var vertices: [Vertex<T>] = []
    
    mutating func createVertex(_ data: T) -> Vertex<T> {
        let vertex = Vertex(data: data, index: adjacencyMatrix.count)
        
        for i in 0..<adjacencyMatrix.count {
            adjacencyMatrix[i].append(nil)
        }
        let newRow = [Double?](repeating: nil, count: adjacencyMatrix.count + 1)
        adjacencyMatrix.append(newRow)
        vertices.append(vertex)
        
        return vertex
    }
    
    mutating func connect(_ sourceVertex: Vertex<T>, to destinationVertex: Vertex<T>, withWeight weight: Double = 0) {
        adjacencyMatrix[sourceVertex.index][destinationVertex.index] = weight
    }
    
    func weightFrom(_ sourceVertex: Vertex<T>, toDestinationVertex: Vertex<T>) -> Double? {
        return adjacencyMatrix[sourceVertex.index][toDestinationVertex.index]
    }
}


extension Graph: CustomStringConvertible {
    public var description: String {
        get {
            var grid = [String]()
            let n = self.adjacencyMatrix.count
            for i in 0..<n {
                var row = ""
                for j in 0..<n {
                    if let value = self.adjacencyMatrix[i][j] {
                        let number = NSString(format: "%.1f", value)
                        row += "\(value >= 0 ? " " : "")\(number) "
                    } else {
                        row += "  ø  "
                    }
                }
                grid.append(row)
            }
            return (grid as NSArray).componentsJoined(by: "\n")
        }
    }
}

var graph = Graph<Int>()
let v1 = graph.createVertex(1)
let v2 = graph.createVertex(2)
let v3 = graph.createVertex(3)
let v4 = graph.createVertex(4)
let v5 = graph.createVertex(5)

graph.connect(v1, to: v2, withWeight: 1.0)
graph.connect(v2, to: v3, withWeight: 1.0)
graph.connect(v3, to: v4, withWeight: 4.5)
graph.connect(v4, to: v1, withWeight: 2.8)
graph.connect(v2, to: v5, withWeight: 3.2)

print(graph)
