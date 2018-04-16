//: Playground - noun: a place where people can play

import Cocoa

private var uniqueIDCounter = 0

//  边 => 从哪(form) 到哪(to) 权重(weight)
struct Edge<T> {
    let from: Vertex<T>
    let to: Vertex<T>
    let weight: Double
    
}

//  顶点 => 数据(data) 唯一标识(uniqueID) 边的集合(edges)
struct Vertex<T> {
    var data: T
    var uniqueID: Int
    var edges: [Edge<T>] = []
    
    init(data: T) {
        self.data = data
        uniqueID = uniqueIDCounter
        uniqueIDCounter += 1
    }
    
    mutating func connectTo(destinationVertex: Vertex<T> , withWeight weight: Double = 0) {
        edges.append(Edge(from: self, to: destinationVertex, weight: weight))
        
    }
    
    public func edgeTo(otherVertex: Vertex<T>) -> Edge<T>? {
        for e in edges where e.to.uniqueID == otherVertex.uniqueID {
            return e
        }
        return nil
    }
    
}
