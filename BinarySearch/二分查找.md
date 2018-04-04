# 二分查找

#### 如何在数组中查找一个元素的位置

我们怎样才能通过一个值,来获取这个值数组中的位置呢?
大多数情况下,我们会用到swift所提供的方法:

``` swift 

let numbers = [11, 59, 3, 2, 53, 17, 31, 7, 19, 67, 47, 13, 37, 61, 29, 43, 5, 41, 23]
numbers.indexOf(43)  // returns 15

```
这样我们就能得到对应值的索引
 
如果我们会想用一个线性(**Linear Search**)的方式来实现这样一个查找过程,通常会这样:
``` swift

extension Array {
    
    func linearSearch<T: Equatable>( key: T) -> Int? {
        
        guard let array: [T] = self as? [T] else {
            return nil
        }
        
        for i in 0 ..< array.count {
            if array[i] == key {
                return i
            }
        }
        return nil
    }

}

numbers.linearSearch(key: 43) // returns 15
```

下面我们看看这种方式存在的问题,`linearSearch()`这方法的查询是以数组的起始位置开始,直到查到了对应的结果才会返回,这就导致了可能我们要遍历完整个数组的内容才能找到对应元素的位置.这看起来会让整个查询过程非常缓慢,时间复杂度为 **O(n)**.

#### 如何更快速的在数组中查找一个元素的位置

有一种经典的方法处理此类问题是使用**二分查找**,原理是把数组分成两半,直到这个值被查到.
如果是线性查找,它的时间复杂度为 **O(n)**,而使用二分查找,时间复杂度仅为 **O(log n)**.通常情况下,二分法查找**1,000,000**个元素只需要20步,因为`log_2(1,000,000) = 19.9`.

二分查找，优点是比较次数少，查找速度快，平均性能好；其缺点是要求待查表为有序表，这就导致了元素插入删除困难.因此，折半查找方法适用于不经常变动而查找频繁的有序列表.


#### 二分查找原理

1. 将数组分成两半，并确定您要查找的元素，即搜索关键字，是在左边还是在右边.
2. 如何确定搜索key的哪一边？首先要对数组排序,这样就能用`<`或`>`来比较元素大小,然后判断在哪一个方向.
3. 如果查找的key在左边的一边,我们就将查询末端设置为原来的中心位置,如果在右边,我们会将整个的中心位置右移一位,依次递归查找到对应的key.
4. 如果数组已经不能拆分,我们要返回一个空值.

现在你知道为什么叫它二分查找了吗,每一次我们的搜索范围都缩小一半,这样就可以更加快速的查找我们所要的内容了.

下面我们用swift来实现一下:

``` swift 

extension Array {
    
    func binarySearch<T: Comparable>(key: T) -> Int? {
        guard let array: [T] = self as? [T] else {
            return nil
        }
        var low = 0
        var upper = array.count
        while low < upper {
            let mid = low + (upper - low) / 2
            if array[mid] == key {  //  查到结果
                return mid
            } else if array[mid] > key {    //  待查结果比当前结果小,在左边部分
                upper = mid
            } else {    //  待查结果比当前结果大,在右边部分
                low = mid + 1
            }
        }

        return nil
    }

}

let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]

print(numbers.binarySearch(key: 2) ?? "none")

```

#### 最后
二分查找的一个弊端是待查的一定要是有序内容,在我们的实际项目中,往往排序的时间要远高于平常的线性查找,所以二分查找适合排序依次后进行多次查询的场景下使用.


