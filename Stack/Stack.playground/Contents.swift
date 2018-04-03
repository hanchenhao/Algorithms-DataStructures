//: Playground - noun: a place where people can play

import UIKit

public struct Stack<T> {
    //  创建一个数组
    var array = [T]()
    //  入栈,将元素插入数组末端
    mutating func push(_ element: T) -> Void {
        array.append(element)
    }
    //  出栈,将数组的末端元素移除
    mutating func pop() -> T? {
        return array.isEmpty ?  nil : array.removeLast()
    }
    //  获取栈顶元素
    func peek() -> T? {
        return array.last
    }
}


var stack = Stack(array: ["a","b","c"])
stack.push("d")
print(stack.peek() ?? "none")
stack.pop()
print(stack.peek() ?? "none")
