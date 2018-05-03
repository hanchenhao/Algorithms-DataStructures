//: Playground - noun: a place where people can play

import Cocoa

//  给定一个 n*m 的矩阵a,每次只能移动一步(只能向右或向左)
//  求出从a[0][0] 移动到 a[n-1][m-1]的最大值
//  利用动态规划,来计算移动线路并求出最大值

func max(_ matrix: [[Int]]) -> Int {
    var dy = matrix
    for (index,value) in matrix.enumerated().reversed() {
        for  (i,v) in value.enumerated().reversed() {
            if index == matrix.count - 1  { //最后一行
                if  index >= 1 , i < value.count - 1 {
                    dy[index][i] = v + dy[index][i+1]
                }
            } else {
                dy[index][i] = value.count - 1 == i ?  v + dy[index + 1][i] : v + max(dy[index+1][i], dy[index][i+1])
            }
        }
    }
    
    return dy.first?.first ?? 0
}

let matrix = [[4,1,3],
             [2,3,2],
             [1,1,2]]

print(max(matrix))
