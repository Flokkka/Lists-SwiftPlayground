import Foundation
import UIKit

internal class ListDrawingContainerView<T: Equatable>: UIView {
    
    public var lists: [List<T>] = []
    private var lastFunctionsCalled: [[String]] = []
    
    public var numberOfLists: Int {
        return lists.count
    }
    
    internal let labelHeight: CGFloat = 30
    internal let mainViewHeight: CGFloat = 200
    internal let operationsInfoHeight: CGFloat = 150
    
    public var contentHeight: CGFloat {
        return (labelHeight + mainViewHeight + operationsInfoHeight) * CGFloat(numberOfLists) - operationsInfoHeight
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func show(_ list: List<T>) {
        backgroundColor = UIColor.white
        lists.append(list.copy())
        self.lastFunctionsCalled.append(list.lastFunctionsCalled)
        list.lastFunctionsCalled = []
    }
    
    public func draw() {
        var tempPosY: CGFloat = 0
        for i in 0 ..< numberOfLists {
            
            addLabel(text: "  Step " + String(i + 1), marginToTop: tempPosY)
            
            tempPosY += labelHeight
            
            addListView(marginToTop: tempPosY, i: i)
            tempPosY += mainViewHeight
            
            if i < numberOfLists - 1 {
                if self.lastFunctionsCalled[i+1].count > 0 {
                    var text = ""
                    for t in self.lastFunctionsCalled[i+1] {
                        text += t + "\n"
                    }
                    addTextView(text: text, marginToTop: tempPosY + 20)
                }
                tempPosY += operationsInfoHeight
            }
        }
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        var tempY: CGFloat = labelHeight + mainViewHeight + 5
        
        for _ in 0..<numberOfLists - 1 {
            let path = UIBezierPath()
            UIColor.black.setStroke()
            path.lineWidth = 3
            
            //down
            path.move(to: CGPoint(x: 30, y: tempY))
            path.addLine(to: CGPoint(x: 30, y: tempY + operationsInfoHeight - 20))
            
            //arrow left part
            path.move(to: CGPoint(x: 30, y: tempY + operationsInfoHeight - 20))
            path.addLine(to: CGPoint(x: 15, y: tempY + operationsInfoHeight - 40))
            
            //arrow right part
            path.move(to: CGPoint(x: 30, y: tempY + operationsInfoHeight - 20))
            path.addLine(to: CGPoint(x: 45, y: tempY + operationsInfoHeight - 40))
            
            
            path.stroke()
            tempY += labelHeight + mainViewHeight + operationsInfoHeight
        }
    }
    
    
}
