import Foundation
import UIKit


public class InteractiveDeleteView<T: Equatable>: UIView, ListNodeDelegate {
    
    private var listViewDynamic: ListDrawingView<T>!
    private var listViewStatic: ListDrawingView<T>!
    
    private let list: List<T>
    
    private var pointsDynamic: [ListNodePoint]!
    private var scrollViewStatic: UIScrollView!
    
    private let listViewHeight: CGFloat = 200
    private let elementWidth: CGFloat = 144
    
    public init(list: List<T>) {
        self.list = list
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white

        listViewDynamic = ListDrawingView(list: list, frame: CGRect(x: 0, y: 0, width: CGFloat(list.size + 2) * elementWidth, height: listViewHeight), listNodeDelegate: self)
        var scrollViewDynamic = UIScrollView()
        addListView(&listViewDynamic!, toScrollView: &scrollViewDynamic, marginToTop: 20)
        pointsDynamic = listViewDynamic.points
        
        listViewStatic = ListDrawingView(list: list, frame: CGRect(x: 0, y: 0, width: CGFloat(list.size + 2) * elementWidth, height: listViewHeight), listNodeDelegate: self, canEdit: false)
        scrollViewStatic = UIScrollView()
        addListView(&listViewStatic!, toScrollView: &scrollViewStatic!, marginToTop: listViewHeight + 120)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addListView(_ view: inout ListDrawingView<T>, toScrollView scrollView: inout UIScrollView, marginToTop: CGFloat) {
        scrollView.contentSize = CGSize(width: view.totalWidth, height: listViewHeight)
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        scrollView.addSubview(view)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: marginToTop))
        self.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: listViewHeight))
    }
    
    public func deleteListElement(atIndex index: Int) {
        //updated dynamic list
        pointsDynamic[index].deleted = true
        let prevIndex = pointsDynamic[index].prevIndex
        let nextIndex = pointsDynamic[index].nextIndex
        pointsDynamic[prevIndex].nextIndex = pointsDynamic[index].nextIndex //successor of predecessor is predecessor of current
        pointsDynamic[nextIndex].prevIndex = pointsDynamic[index].prevIndex //predecessor of next is predecessor of current
        listViewDynamic.points = pointsDynamic
        listViewDynamic.setNeedsDisplay()
        
        //update static list
        let updatedList = createUpdatedList()
        listViewStatic.frame.size = CGSize(width: CGFloat(updatedList.size + 2) * elementWidth, height: listViewHeight)
        listViewStatic.updateContentsToList(list: createUpdatedList())
        scrollViewStatic.contentSize = CGSize(width: listViewStatic.totalWidth, height: listViewHeight)
    }
    
    
    private func createUpdatedList() -> List<T> {
        let listTemp = List<T>()
        var node = list.head
        var i = 1
        while node != nil {
            if !pointsDynamic[i].deleted {
                listTemp.add(node!.element)
            }
            node = node?.next
            i += 1
        }
        return listTemp
    }
    
}
