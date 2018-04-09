//: Playground - noun: a place where people can play


import Foundation

class TreeNode<T> {
    var value: T    //  值
    var parent: TreeNode?   //  父节点
    var children = [TreeNode<T>]()  //  子节点集合
    
    init(value: T) {
        self.value = value
    }
    
    func addChild(node: TreeNode<T>) -> Void {
        children.append(node)
        node.parent = self
    }
}


//  序列化输出TreeNode的内容
extension TreeNode: CustomStringConvertible {
    public var description: String {
        var s = "\(value)"
        if !children.isEmpty {
            s +=  " {" +  children.map { $0.description }.joined(separator: "  ,") + "}"
        }
        return s
    }
}


let tree = TreeNode<String>.init(value: "tree")
let leap = TreeNode<String>.init(value: "leap")
let flower = TreeNode<String>.init(value: "flower")

tree.addChild(node: leap)
tree.addChild(node: flower)

print(tree.description)

for _ in 0...10 {
    let leapChild = TreeNode<String>.init(value: "leap-child")
    leap.addChild(node: leapChild)
}

for _ in 0...5 {
    let flowerChild = TreeNode<String>.init(value: "flower-child")
    flower.addChild(node: flowerChild)
}

print(tree.description)

