# 树

用树这种数据结构表示对象之间的层次关系,其形状像一颗树
一个树形的数据结构有若干节点,它们互相连接着彼此,节点与其子节点相互关联,通常子节点指向它们的父节点,在树形的数据结构中,节点总是只有一个父节点,而可以有很多歌子节点

下面我们用swift来实现一个基本的树形数据结构:

```swift

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

```

这是一个没有枝叶的树,下面我们给它加一点内容:

```swift

let tree = TreeNode<String>.init(value: "tree")
let leap = TreeNode<String>.init(value: "leap")

tree.addChild(node: leap)
tree.addChild(node: flower)

```

序列化输出:
```swift

extension TreeNode: CustomStringConvertible {
    public var description: String {
        var s = "\(value)"
        if !children.isEmpty {
            s +=  " {" +  children.map { $0.description }.joined(separator: "  ,") + "}"
        }
        return s
    }
}

print(tree.description)

```

下面我们就看到了一个基本的树的结构:

```swift
tree {leap  ,flower}
```

再给树添加一些枝蔓:

```swift

for _ in 0...10 {
    let leapChild = TreeNode<String>.init(value: "leap-child")
    leap.addChild(node: leapChild)
}

for _ in 0...5 {
    let flowerChild = TreeNode<String>.init(value: "flower-child")
    flower.addChild(node: flowerChild)
}

```

最后的输出结果为:

```swift

tree {leap {leap-child  ,leap-child  ,leap-child  ,leap-child  ,leap-child  ,leap-child  ,leap-child  ,leap-child  ,leap-child  ,leap-child  ,leap-child}  ,flower {flower-child  ,flower-child  ,flower-child  ,flower-child  ,flower-child  ,flower-child}}


```




