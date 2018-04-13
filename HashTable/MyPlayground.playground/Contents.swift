//: Playground - noun: a place where people can play

import Cocoa


struct HashTable<Key: Hashable , Value> {
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]
    
    init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array.init(repeating: [], count: capacity)
    }
    private func indexForKey(key: Key) -> Int {
        return abs(key.hashValue) % buckets.count
    }
}

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


var a = HashTable<String, Any>(capacity: 1)

a["firstName"] = "Han"
a["hobbies"] = "Programming Swift"
print("\(a["firstName"]!) and \(a["hobbies"]!) ")
a.removeValue(forKey: "firstName")
print(a["firstName"] ?? "none")
print(a["hobbies"] ?? "none")
