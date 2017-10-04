/*:
 Besides [adding](Adding%20elements) and [deleting](Deleting%20elements%20I) elements from a list, there are many other operations which can be performed on lists.
 */
/*:
 **1. Getting an element by index**
 */
/*:
 When using ````list.get(_ index: Int) -> T?```` the element at the specified index is returned if it exists, otherwise nil is returned.
 */
/*:
    let listElement = list.get(4)!
    print(listElement) //prints 5
 */

/*:
 **2. Checking if a list contains an element**
 */
/*:
 You can use ````list.contains(_ element: T) -> Bool```` to check whether a list contains an element T.
 */
/*:
    let containsTwo = list.contains(2)
    print(containsTwo) //prints true
 */

/*:
 **3. Getting the index of an element**
 */
/*:
 Use ````indexOf(_ element: T) -> Int```` to get the index of an element. If the list doesn't contain that element, -1 is returned.
 */
/*:
    let index = list.indexOf(3)
    print(index) //prints 2
 */

/*:
 **4. Getting the size of a list**
 */
/*:
 Use ````list.size```` to get the number of elements in the list.
 */
/*:
    let numberOfElements = list.size
    print(numberOfElements) //prints 6
 */

/*:
 * callout(Task):
    Delete the second last element in the list. If a node with element 4 exists, add an element with 8 before that.
 */
//#-hidden-code
import PlaygroundSupport
import Foundation

let proxy = PlaygroundPage.current.liveView as! PlaygroundRemoteLiveViewProxy
let listener = LiveViewListener<Int>()
proxy.delegate = listener
listener.dispatchGroup.enter()
proxy.send(.string("bla"))
var list = List<Int>()
let goalList = List<Int>(elements: [8, 4, 6, 3, 2, 8])


listener.dispatchGroup.notify(queue: .main) {
    list = listener.list
    list.lastFunctionsCalled = []
    
    //#-end-hidden-code
    //#-code-completion(everything, hide)
    //#-code-completion(identifier, show, list, size, add(_:), add(index:element:), remove(element:), remove(index:), get(_:), contains(_:), indexOf(_:))
    //#-code-completion(keyword, show, if)
    //#-code-completion(literal, show, boolean)
    
    //#-editable-code Tap to enter code
    //#-end-editable-code
    
    
    //#-hidden-code
    if list.isEqualTo(goalList) {
        PlaygroundPage.current.assessmentStatus = .pass(message: "Nice!")
    }
    else {
        let solution = "Try this: \n \n ````let secondLastIndex = list.size - 2```` \n \n````list.remove(index: secondLastIndex)```` \n \n````if list.contains(4) {```` \n \n````let index = list.indexOf(4)````\n \n````list.add(index: index, element: 8)```` \n \n````}````"
        PlaygroundPage.current.assessmentStatus = .fail(hints: ["Press \"**Run My Code**\" again if you want to continue working with the **current list**. If you want to start over you can **reset the page**"], solution: solution)
    }
    
    let data = NSKeyedArchiver.archivedData(withRootObject: list)
    proxy.send(.data(data))
}

//#-end-hidden-code
