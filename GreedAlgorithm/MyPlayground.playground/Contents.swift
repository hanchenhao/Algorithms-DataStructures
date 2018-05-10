//: Playground - noun: a place where people can play

import Cocoa


/*
 
 对于现实生活中的找零问题，假设有数目不限，面值为20,10,5,1的硬币。
 求出找零方案，要求：使用数目最少的硬币。
 
 */

func greedSelector(_ par: [Int] , money: Int) -> [Int] {
    let n = par.count - 1
    let array = par.sorted{$0 > $1}
    var currentMoney = money
    var send = [Int]()
    
    for i in 0...n {
        while array[i] <= currentMoney , currentMoney >= 0{
            send.append(array[i])
            currentMoney -= array[i]
        }
    }
    
    if currentMoney != 0 { print("面值不满足找零") }
    return send
}


// TEST CASE

print(greedSelector([5,1,20,10], money: 113))

