# 快速排序

快速排序是一种历史上非常流行的算法,它在1959年,递归概念都很模糊的时候,被**Tony Hoare**创造

下面我们用swift来写一个很容易理解的版本:

```swift

func quickSort<T: Comparable>(array: [T]) -> [T] {
    guard array.count > 1 else {
        return array
    }
    let a = array
    let ave = Int(a.count / 2)
    let c = array[ave]
    
    let less =  a.filter({$0 < c})
    let eq =  a.filter({$0 == c})
    let more =  a.filter({$0 > c})
    
    return quickSort(array: less) + eq + quickSort(array: more)
    
    
}

```

下面我们来看看快速排序的工作原理,它其实是在一个数组中找到一个基准值,在理想状态下,通过这个值我们将数组分成三部分,其中分别是比基准值大的部分,比基准值小的部分,以及和基准值相等的部分,这样的话,我们只需要递归这几部分就可以得到最终的答案

比如当前我们有一个数组

	[ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]

首先我们会选择数组中间的元素当基准值,这个值是`8`,我们以8为中心分别排列

	less:    [ 0, 3, 2, 1, 5, -1 ]
	equal:   [ 8, 8 ]
	greater: [ 10, 9, 14, 27, 26 ]

通过上述排列,我们得到了三个数组,我们再用相同的方式来排列当前这个`less`数组

`less`数组现在是这个样子的

	[ 0, 3, 2, 1, 5, -1 ]

我们找到他基准值继续拆分

	less:    [ 0, -1 ]
	equal:   [ 1 ]
	greater: [ 3, 2, 5 ]

以此类推,我们继续拆分`less`会变成

	less:    [ ]
	equal:   [ -1 ]
	greater: [ 0 ]
	

用同样的方式,我们拆分`greater`最终会得到下面这个结果

	less:    [ ]
	equal:   [ 2 ]
	greater: [ 3, 5 ]
	
	less:    [ ]
	equal:   [ 2 ]
	greater: [
		less:    [ 3 ]
		equal:   [ 5 ]
		greater: [ ]
	]

我们分别将这些数组组装成一个完整的数组之后就成为了一个排好序的数组了

	[ -1, 0, 1, 2, 3, 5, 8, 8, 9, 10, 14, 26, 27 ]




