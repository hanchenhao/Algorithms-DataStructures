# 归并排序

归并排序(**Merge Sort**)是**John von Neumann**与1945年创造的,它是性能最好的排序算法之一,但是他的时间复杂度为 **O(n log n)**

归并排序的主要思想是将大问题归类成若干个更小的问题来替代,解决小问题后将这些内容合并

我们把归并的思想用到数组的排序中,我们先将一个有 **n** 个元素的数组归类成若干小数组,然后分别排序后合并

比如我们要将`[2, 1, 5, 4, 9]`这个数组排序

首先我们要将这个数组归类成小数组,比如先分成两个 `[2, 1,] ` 和 `[5, 4, 9]` ,这样的话就成了左边的数组和右边的数组,然后我们利用递归的思想,再将这些小数组进行拆分,直到最后拆分成只有一个元素的数组, `[2]` `[1]` `[5]` `[4]` `[9]`

然后我们要将归类拆分的数组合并,在合并的同时我们要进行相应的排序,这其实就是刚才说的归并思想,我们将一个大问题拆分成若干小问题依次来解决

第一轮合并我们会得到 `[1, 2]` 和 `[4, 5]` 以及 `[9]` 三个数组,我们继续排序并合并,会合并成 `[1, 2]` 和 `[4, 5, 9]` 两个数组, 依次递归以后会合并成一个完整的排序好的数组, `[1, 2, 4, 5, 9]`

代码如下

```swift

func mergeSort<T: Comparable>(array: [T]) -> [T] {
    guard array.count > 1 else {
        return array
    }
    let ave = array.count / 2
    let left = mergeSort(array: Array(array[0..<ave]))
    let right =  mergeSort(array: Array(array[ave..<array.count]))
    return merge(left: left, right: right)
}


func merge<T: Comparable>(left: [T] , right: [T]) -> [T] {
    var lIndex = 0
    var rIndex = 0
    var mArray = [T]()
    
    while lIndex < left.count && rIndex < right.count {
        if left[lIndex] > right[rIndex] {
            mArray.append(right[rIndex])
            rIndex += 1
        } else if left[lIndex] < right[rIndex] {
            mArray.append(left[lIndex])
            lIndex += 1
        } else {
            mArray.append(left[lIndex])
            lIndex += 1
            mArray.append(right[rIndex])
            rIndex += 1
        }
    }

    while lIndex < left.count {
        mArray.append(left[lIndex])
        lIndex += 1
    }

    while rIndex < right.count {
        mArray.append(right[rIndex])
        rIndex += 1
    }
    return mArray
}

```


