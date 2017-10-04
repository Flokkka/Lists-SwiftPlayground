/*:
 **Goal:** Add items to a list.
 
 In the [introduction](Introduction) to lists, you've learnt that a list can store many items of the same type.
 This example uses a [**generic**](glossary://generic) list of type Int.

*/
/*:
 ````let list = List<Int>()````
 */
/*:
 This means that you can only add numbers to the list. Take a look at the list on the right (at step 1).
 There are no elements in the list (yet) so the the [**head**](glossary://head) of the list points to nil.
 */
/*:
 Let's add some elements to the list:
    
    list.add(9)
    list.add(7)
    list.add(index: 1, element: 3)
 
 Note that the list now contains three nodes. First we added 9 at the end of the list, then 7, and after that 3 between the other two.
 */

/*:
  * callout(Task):
  Use ````list.add(_ element: T)```` and ````list.add(index: Int, element: T)```` to create a list that looks like this: 2 -> 9 -> 6 -> 3 -> 7 -> 5
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
let goalList = List<Int>(elements: [2, 9, 6, 3, 7, 5])


listener.dispatchGroup.notify(queue: .main) {
    list = listener.list
    list.lastFunctionsCalled = []
    //#-end-hidden-code
    //#-code-completion(everything, hide)
    //#-code-completion(identifier, show, list, add(_:), add(index:element:))

//#-editable-code Tap to enter code
//#-end-editable-code
    
    
    //#-hidden-code
    if list.isEqualTo(goalList) {
        PlaygroundPage.current.assessmentStatus = .pass(message: "Good job!")
    }
    else {
        let solution = "Try this: \n1. ````list.add(index: 0, element: 2)```` \n2. ````list.add(index: 2, element: 6)```` \n3. ````list.add(5)````"
         PlaygroundPage.current.assessmentStatus = .fail(hints: ["Press \"**Run My Code**\" again if you want to continue adding elements to the **current list**. If you want to start over you can **reset the page**"], solution: solution)
    }
    
    let data = NSKeyedArchiver.archivedData(withRootObject: list)
    proxy.send(.data(data))
}

//#-end-hidden-code
