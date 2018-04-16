# 插入排序

插入排序的工作方式如下：

- 首先，将这些待排序的数字放在一个数组中，成为未排序的原始数组。
- 从其中取出一个数字，具体取哪个无所谓。为简单起见，每次都直接取出第一个元素。
- 将这个数字插入到一个新的已排序数组中。
- 然后再次从未排序数组中取出一个数字，将其插入到已排序数组中。它要么插在第一个元素的前面，要么插在后面，来保证这两个数字是有序的。
- 再一次从未排序数组中取出一个元素，安插在新数组的合适位置，以求新数组依然有序。
- 一直这样做下去，直到未排序数组中没有数字了为止。这样就可以达到排序的目的了。

这就是算法叫“插入”排序的原因，因为排序过程中不断地从未排序数组中取出元素插入到已排序的目标数组。

## 举例

例如，待排序的数组为 `[ 8, 3, 5, 4, 6 ]`。

取出第一个数字 `8`，将它插入到已排序数组中。已排序数组目前还是空的，所以这个过程非常简单。已排序数组现在为 `[ 8 ]`，未排序数组为 `[ 3, 5, 4, 6 ]`。

取出下一个数字 `3`，将其插入到已排序数组。他应该在 `8` 的前面，所以已排序数组现在为 `[ 3, 8 ]`，未排序数组缩减为 `[ 5, 4, 6 ]`

取出下一个数字 `5`，将其插入到已排序数组中。它应该在 `3` 和 `8` 之间。所以，现在已排序数组为 `[ 3, 5, 8]`,未排序数组为 `[ 4, 6 ]`。

重复以上过程，直到未排序数组为空为止。

## 原地排序

根据上面的解释，排序过程中似乎使用了两个数组，一个用于存放未排序的的元素，另一个存放已排序的元素。

但实际上插入排序可以“原地”进行，无需再创建另一个数组。只需要标记好哪部分是未排序的，哪部分是已排序的即可。

初始数组为 `[ 8, 3, 5, 4, 6 ]`。我们使用 `|` 符号来分隔已排序和未排序部分：

	[| 8, 3, 5, 4, 6 ]

上图显示已排序部分为空，未排序部分的第一个数字为 `8`。

处理完第一个数字之后，数组如下所示：

	[ 8 | 3, 5, 4, 6 ]

目前，已排序的部分为 `[ 8 ]`，未排序的部分为 `[ 3, 5, 4, 6 ]`。分隔符 `|` 向右位移了一个单位。

下面列出了排序过程中数组内容的变化：

	[| 8, 3, 5, 4, 6 ]
	[ 8 | 3, 5, 4, 6 ]
	[ 3, 8 | 5, 4, 6 ]
	[ 3, 5, 8 | 4, 6 ]
	[ 3, 4, 5, 8 | 6 ]
	[ 3, 4, 5, 6, 8 |]

每一步分隔符 `|` 都向右位移一个单位。可以观察到，数组开头到分隔符之间的部分总是已排序的。未排序部分每减少一个元素，已排序部分就增加一个，直到未排序元素为空为止。

## 如何插入

每个周期开始，取出未排序数组的头部元素，将其插入到已排序数组中。这时候，必须要保证元素被插入到了正确的位置。怎么做呢？

现在假设已经完成了前面几个元素的排序，数组看起来像下面这样：

	[ 3, 5, 8 | 4, 6 ]

下一个待排序的数字是 `4`。我们要做的就是将其插入到已排序数组 `[ 3, 5, 8 ]` 的某个位置。

下面提供了一个实现思路：跟前面的元素 `8` 进行比较。

	[ 3, 5, 8, 4 | 6 ]
	        ^
	        
它比 `4` 大吗？是的，所以 `4` 应该放到 `8` 的前面去。我们将两个数字交换位置来达到目的：

	[ 3, 5, 4, 8 | 6 ]
	        <-->
	       已交换

至此还没有结束。交换之后，新的排在前面的元素 `5` 也比 `4` 大。我们如法炮制，也将这两个数字交换位置：

	[ 3, 4, 5, 8 | 6 ]
	     <-->
	    已交换

继续，再次检查排在前面的新元素 `3`，它比 `4` 大吗？不，它必 `4` 小，这就意味着 `4` 已经在正确的位置上了。已排序的数组也再次变得有序了。

这就是插入排序算法的内循环的文字描述了，具体的代码在下一节给出。通过交换数字的方式，我们将待排序的元素移动到了已排序数组的正确位置上。


```swift

func insertionSort<T: Comparable>(array: [T] , _ compare:(T,T) -> Bool) -> [T] {
    var a = array
    
    for i in 1..<a.count {
        var n = i
        while n > 0 && compare(a[n] , a[n-1]) {
            a.swapAt(n, n-1)
            n -= 1
        }
    }
    return a
}


```

