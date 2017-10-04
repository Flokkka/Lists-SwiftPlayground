/*:
 **Goal:** Remove items from a list.
 */
/*:
 ````let list = List<Int>(elements: [7, 3, 9, 5, 9, 4, 5, 1])````
 */
/*:
 The initializer above uses an [**array**](glossary://array) in order to construct a list.
 */
/*:
 Let's delete some elements from the list:
 
    list.remove(element: 3)
    list.remove(index: 4)
    list.remove(element: 9)
 
 Keep in mind that ````list.remove(9)```` only removes the first occurence of 9 from the list.
 */
/*:
 You can use ````list.clear()```` to remove all items from a list.
 */

/*:
 * callout(Task):
 Use ````list.remove(element: T)```` and ````list.remove(index: Int)```` to create a list that looks like this: 5 -> 9 -> 1
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
let goalList = List<Int>(elements: [5, 9, 1])


listener.dispatchGroup.notify(queue: .main) {
    list = listener.list
    list.lastFunctionsCalled = []

    //#-end-hidden-code
    //#-code-completion(everything, hide)
    //#-code-completion(identifier, show, list, remove(element:), remove(index:))
    
    //#-editable-code Tap to enter code
    //#-end-editable-code
    
    
    //#-hidden-code
    if list.isEqualTo(goalList) {
        PlaygroundPage.current.assessmentStatus = .pass(message: "You did it!")
    }
    else {
        let solution = "Try this: \n1. ````list.remove(index: 3)```` \n2. ````list.remove(element: 7)````"
        PlaygroundPage.current.assessmentStatus = .fail(hints: ["Press \"**Run My Code**\" again if you want to continue removing elements from the **current list**. If you want to start over you can **reset the page**"], solution: solution)
    }
    
    let data = NSKeyedArchiver.archivedData(withRootObject: list)
    proxy.send(.data(data))
}

//#-end-hidden-code
