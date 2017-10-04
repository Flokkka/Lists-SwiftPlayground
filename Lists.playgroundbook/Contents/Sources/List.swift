import Foundation

public class List<T: Equatable>: NSObject, ListStandard, NSCoding {
    
    public var lastFunctionsCalled: [String] = []
    
    internal(set) var head: Node<T>?
    
    internal var isEmpty: Bool {
        return head == nil
    }
    
    override public var description: String {
        var desc: String = "{"
        var tmp = head
        while tmp != nil {
            desc += String(describing: tmp!.element) + (tmp!.next != nil ? ", " : "")
            tmp = tmp?.next
        }
        desc += "}"
        return desc
    }
    
    /// the number of elements in the list
    public var size: Int {
        var count: Int = 0
        var tmp = head
        while (tmp != nil) {
            count += 1
            tmp = tmp?.next
        }
        return count
    }
    
    public init(element: T) {
        head = Node(next: nil, element: element)
    }
    
    public override init() {}
    
    public init(elements: [T]) {
        if elements.count != 0 {
            var prevNode: Node<T>?
            for i in 0 ..< elements.count {
                if i == 0 {
                    head = Node(next: nil, element: elements.first!)
                    prevNode = head!
                }
                else {
                    let node = Node(next: nil, element: elements[i])
                    prevNode!.next = node
                    prevNode = node
                }
            }
        }
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        self.init()
        self.lastFunctionsCalled = aDecoder.decodeObject(forKey: "lastFunctionsCalled") as! [String]
        self.head = aDecoder.decodeObject(forKey: "head") as! Node<T>?
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(lastFunctionsCalled, forKey: "lastFunctionsCalled")
        if let head = head { aCoder.encode(head, forKey: "head")}
    }
    
    /// adds an element at the end of the list
    ///
    /// - Parameter element: the element
    public func add(_ element: T) {
        log("list.add(" + String(describing: element) + ")")
        
        if (isEmpty) {
            head = Node(next: nil, element: element)
        }
        else {
            var tmp = head
            while (tmp?.next != nil) {
                tmp = tmp?.next
            }
            tmp?.next = Node(next: nil, element: element)
        }
    }
    
    /// Adds an element at the specified index
    ///
    /// - Parameters:
    ///   - index: index where the element should be added
    ///   - element: the element
    public func add(index: Int, element: T) {
        log("list.add(index: " + String(index) + ", element: " + String(describing: element) + ")")

        if index < 0 {
            logResult("Error. Index cannot be negative.")
            return
        }
        if index == 0 {
            let headTemp = head
            let nodeNew = Node(next: headTemp, element: element)
            head = nodeNew
            return
        }
        else {
            var prev = head
            var curr = head
            var i = 0
            while (curr != nil) {
                i += 1
                prev = curr
                curr = curr!.next
                if i == index {
                    let nodeNew = Node(next: curr, element: element)
                    prev!.next = nodeNew
                    return
                }
            }
        }
        
        logResult("Error. Index is too large.")
        
    }
    
    /// adds a list at the end of the list
    ///
    /// - Parameter list: the list to be added
    public func addAll(list: List<T>) {
        log("list.addAll(" + String(describing: list) + ")")
        
        if isEmpty {
            head = list.head
        }
        else {
            var tmp = head
            while tmp?.next != nil {
                tmp = tmp?.next
            }
            tmp?.next = list.head
        }
    }
    
    /// removes an element from the list
    ///
    /// - Parameter element: the element that should be deleted
    /// - Returns: true if successful, else false
    public func remove(element: T) -> Bool {
        log("list.remove(element: " + String(describing: element) + ")")
        
        if isEmpty {
            logResult("false | List is empty.")
            return false
        }
        if head!.element == element {
            head = head?.next
        }
        var prev = head
        var curr = head
        while (curr != nil) {
            if curr!.element == element {
                prev!.next = curr!.next
                logResult("true")
                return true
            }
            prev = curr
            curr = curr?.next
        }
        
        logResult("false | element not found")
        return false
    }
    
    /// removes an element at an index from the list
    ///
    /// - Parameter index: the index
    /// - Returns: the element that got deleted, nil if unsuccessful
    public func remove(index: Int) -> T? {
        log("list.remove(index: " + String(index) + ")")
        
        if index < 0 || isEmpty {
            logResult("nil")
            return nil
        }
        
        if index == 0 {
            let tmp = head!.element
            head = head!.next
            logResult(String(describing: tmp))
            return tmp
        }
        else {
            var prev = head
            var curr = head
            var i = 0
            while i < index && curr!.next != nil {
                prev = curr
                curr = curr?.next
                i += 1
            }
            
            if i < index {
                logResult("nil")
                return nil
            }
            
            prev!.next = curr!.next
            logResult(String(describing: curr!.element))
            return curr!.element
        }
    }
    
    /// deletes all elements from the list
    public func clear() {
        log("list.clear()")
        head = nil
    }
    
    /// get an element at an index
    ///
    /// - Parameter index: the index
    /// - Returns: the element
    public func get(_ index: Int) -> T? {
        log("list.get(" + String(index) + ")")
        
        if index < 0 || isEmpty {
            logResult("not found")
            return nil
        }
        
        var tmp = head
        var i: Int = 0
        
        while tmp != nil {
            if index == i {
                logResult(String(describing: tmp!.element))
                return tmp?.element
            }
            tmp = tmp?.next
            i += 1
        }
        
        logResult("not found")
        return nil
    }
    
    /// checks whether the list contains an element
    ///
    /// - Parameter element: the element
    /// - Returns: true if the list contains that element, else false
    public func contains(_ element: T) -> Bool {
        log("list.contains(" + String(describing: element) + ")")
        if isEmpty {
            logResult("false")
            return false
        }
        
        var tmp = head
        while tmp != nil {
            if tmp?.element == element {
                logResult("true")
                return true
            }
            tmp = tmp?.next
        }
        
        logResult("false")
        return false
    }
    
    /// returns the index of an element in the list
    ///
    /// - Parameter element: the element
    /// - Returns: the index of the element, -1 if the element couldn't be found
    public func indexOf(_ element: T) -> Int {
        log("list.indexOf(" + String(describing: element) + ")")
        if isEmpty {
            logResult("-1")
            return -1
        }
        
        var tmp = head
        var i = 0
        while tmp != nil {
            if tmp?.element == element {
                logResult(String(i))
                return i
            }
            tmp = tmp?.next
            i += 1
        }
        logResult("-1")
        return -1
    }
    
    /// compares this list to another list
    ///
    /// - Parameter list: the list to compare this list to
    /// - Returns: true if the list contain the same elements in the same order, else false
    public func isEqualTo(_ list: List<T>) -> Bool {
        if self.size == list.size {
            var tempNodeSelf = self.head
            var tempNodeOther = list.head
            while tempNodeSelf != nil {
                if tempNodeSelf!.element != tempNodeOther!.element {
                    return false
                }
                tempNodeSelf = tempNodeSelf!.next
                tempNodeOther = tempNodeOther!.next
            }
            return true
        }
        
        return false
    }
    
    /// copys a list
    ///
    /// - Returns: the copied list
    public func copy() -> List<T> {
        let neu = List()
        var tmp = head
        while (tmp != nil) {
            neu.add(tmp!.element)
            tmp = tmp?.next
        }
        return neu
        
    }
    
    private func log(_ text: String) {
        lastFunctionsCalled.append(text)
    }
    
    private func logResult(_ text: String) {
        lastFunctionsCalled.append("\t → " + text)
    }
}

protocol ListStandard {
    associatedtype T: Equatable
    func add(_ element: T)
    func add(index: Int, element: T)
    func addAll(list: List<T>)
    func remove(element: T) -> Bool
    func remove(index: Int) -> T?
    func clear()
    func get(_ index: Int) -> T?
    func contains(_ element: T) -> Bool
    func indexOf(_ element: T) -> Int
    func isEqualTo(_ list: List<T>) -> Bool
}


public class Node<T>: NSObject, NSCoding {
    
    override public var description: String {
        return String(describing: element)
    }
    
    /// the successor of this node
    internal var next: Node?
    
    /// the element of this node
    internal var element: T
    
    init(next: Node?, element: T) {
        self.next = next
        self.element = element
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        self.init(next: aDecoder.decodeObject(forKey: "next") as! Node?, element: aDecoder.decodeObject(forKey: "element") as! T)
    }
    
    public func encode(with aCoder: NSCoder) {
        if let next = next { aCoder.encode(next, forKey: "next") }
        aCoder.encode(self.element, forKey: "element")
    }
}
