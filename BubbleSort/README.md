# 冒泡排序

这是一个很糟糕的排序算法,时间复杂度为 **O(n^2) ** 仅存在个别地方面试以及学校考试的时候会用,可以不了解

其原理是数组前后两项两两对比,将符合条件移到指定位置:

```swift

func bubbleSort<T: Comparable>(array: [T]) -> [T] {
    var a = array
    
    for i in 0..<a.count {
        for j in 1..<a.count - i {
            if a[j] > a[j-1] {
                a.swapAt(j, j-1)
            }
        }
    }
    return a
}

```

