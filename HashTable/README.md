# 哈希表

哈希表(散列表)是存储键值对的实体类,是根据关键码值(Key value)而直接进行访问的数据结构。也就是说，它通过把关键码值映射到表中一个位置来访问记录，以加快查找的速度。这个映射函数叫做散列函数，存放记录的数组叫做散列表。

事实上,我们常用的`dictionary`,`map`以及`array`,都同样是是哈希,在swift中,我们每次创建`Dictionary`类型,其中的`key`要遵守`Hashable`这个协议,就是出于这个原因

下面我们看看哈希表是如何工作的:

最基本的哈希表和我们平常用的数组没什么太大的区别,它其实就像是一个空数组,我们将key转化成数组的下标,然后存到对应的位置

```swift
hashTable["firstName"] = "Han"

	The hashTable array:
	+--------------+
	| 0:           |
	+--------------+
	| 1:           |
	+--------------+
	| 2:           |
	+--------------+
	| 3: firstName |---> Han
	+--------------+
	| 4:           |
	+--------------+
```

在这个例子中,我们经过一定的计算,将key `firstName` 转化成了3 并存到数组的指定`index`内,我们再加一个不同的值在这个数组中其他的`index`内

```swift
hashTable["hobbies"] = "Programming Swift"

	The hashTable array:
	+--------------+
	| 0:           |
	+--------------+
	| 1: hobbies   |---> Programming Swift
	+--------------+
	| 2:           |
	+--------------+
	| 3: firstName |---> Han
	+--------------+
	| 4:           |
	+--------------+
```

这样,我们就以key-value的形式将数组存起来了,然后我们可以这样来获取我们存好的值

```swift
hashTable["firstName"] = "Han"
```

当我们取得`firstName`值的时候,实际上是有一个这样的过程,首先会得到`firstName".hashValue`,它是一个很大的整形,然后我们将这个整形进行一定的转化,最终转换成数组中的`index`值,我们通过`index`去数组中取到对应的元素

用哈希很适合做一些增删改查的工作,因为他的复杂度永远是 **O(1)**

下面我们实现一个基本的哈希表:

```swift

struct HashTable<Key: Hashable , Value> {
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]

    init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array.init(repeating: [], count: capacity)
    }
    private func indexForKey(key: Int) -> Int {
        return abs(key.hashValue) % buckets.count
    }
}

```

其中`indexForKey(key: Key)` 是要将我们的`key`值转化为关键码值来映射到一个位置来访问记录

有了基本的哈希结构,我们来完善一下它的基本功能,我们给它加上增删改查

```swift

extension HashTable {
     subscript(key: Key) -> Value? {
        get {
            return valueForKey(key: key)
            
        }
        set {
            if let value = newValue {
                updateValue(value, forKey: key)
            }
        }
    }
    
    func valueForKey(key: Key) -> Value? {
        let index = indexForKey(key: key)

        for element in buckets[index] {
            if element.key == key {
                return element.value
            }
        }
        return nil
    }
    
    mutating func updateValue(_ value: Value, forKey key: Key) -> Void {
        let index = indexForKey(key: key)
        //  有对应的key,替换
        
        for (i,element) in buckets[index].enumerated() {
            if element.key == key {
                buckets[index][i].value = value
                return
            }
        }
        //  没有对应的key,添加新的
        buckets[index].append((key: key, value: value))
    }
    
    mutating func removeValue(forKey key: Key) -> Void {
        let index = indexForKey(key: key)

        buckets[index].enumerated().forEach { (i,element) in
            if element.key == key {
                buckets[index].remove(at: i)
            }
        }
    }
}

```

我们当前完成的这个哈希表是使用了一个固定容量的数组,对于容量，我们可以选择一个我们比最大元素个数大的素数

其中有一个负载因子(**load factor**)的概念,比如在一个哈希表中,我们有三个元素,同时有五个桶,这个时候当前哈希的负载因子就是 `3/5 = 60%`

当负载因子变得很高,比如超过75%的时候,我们就可以考虑去给这个哈希表扩容,以保证程序的稳定运行







