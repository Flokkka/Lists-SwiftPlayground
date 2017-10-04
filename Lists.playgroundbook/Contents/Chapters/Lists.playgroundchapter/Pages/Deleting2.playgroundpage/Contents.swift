//#-code-completion(everything, hide)
/*:
 You've learnt how to remove items from a list in the [last part](Deleting%20elements%20I).
 */
/*:
 In this part you are going to learn what happens when you call ````list.remove(element: T)```` or ````list.remove(index: Int)````.
 */
/*:
 Every [**node**](glossary://node) in the list (blue box) has an element (the number) and a reference to its successor (arrow).
 
 
    public class Node<T> {
 
        var next: Node?
        var element: T
 
        init(next: Node?, element: T) {
            self.next = next
            self.element = element
        }
    }
 
 If the node doesn't have a successor, its next pointer points to nil (red cross). When deleting an item, the only thing you have to do is set the next pointer of its predecessor to its own next pointer.
 
 */

/*:
 * callout(Exercise):
 Tap and hold nodes from the list on the top to delete them. Watch what happens to the next pointers. Notice that the top and the bottom lists are the same.

 
 */
