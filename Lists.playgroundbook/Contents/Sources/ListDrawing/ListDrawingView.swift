import Foundation
import UIKit
import CoreGraphics

internal class ListDrawingView<T: Equatable>: UIView {
    
    private var list: List<T>
    
    private var listNodeDelegate: ListNodeDelegate?
    internal(set) var points: [ListNodePoint]!
    
    private var canEdit: Bool
    
    private var elementWidth: CGFloat {
        return frame.width / CGFloat(list.size + 2) * (4 / 5)
    }
    private var elementHeight: CGFloat {
        return frame.size.height - connectorHeight * 2
    }
    private var spacingX: CGFloat {
        return frame.width / CGFloat(list.size + 2) * (1 / 5)
    }
    private var connectorHeight: CGFloat {
        return frame.size.height * (1 / 5)
    }
    
    private let lineColor: UIColor = UIColor.green
    private let deletedLineColor: UIColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.4)
    
    public var totalWidth: CGFloat {
        return CGFloat(list.size + 2) * (elementWidth + spacingX)
    }
    
    public init(list: List<T>, frame: CGRect, listNodeDelegate: ListNodeDelegate?, canEdit: Bool = true) {
        self.list = list
        self.canEdit = canEdit
        self.listNodeDelegate = listNodeDelegate
        
        super.init(frame: frame)
        
        getDrawPoints()
        addElements()
        
        self.backgroundColor = UIColor.white
    }
    
    
    private func addElements() {
        let head = ListNodeHead(frame: CGRect(x: 0, y: connectorHeight, width: elementWidth, height: elementHeight))
        addSubview(head)
        
        var tempX: CGFloat = elementWidth + spacingX
        
        var node: Node<T>? = list.head
        var i = 1
        while node != nil {
            let elementView = ListNodeView(frame: CGRect(x: tempX, y: connectorHeight, width: elementWidth, height: elementHeight) , text: String(describing: node!), index: i, delegate: listNodeDelegate)
            elementView.isUserInteractionEnabled = canEdit
            addSubview(elementView)
            tempX += elementWidth + spacingX
            node = node!.next
            i += 1
        }
        
        let listNodeNilView = ListNodeNilView(frame: CGRect(x: tempX, y: connectorHeight, width: elementWidth, height: elementHeight))
        addSubview(listNodeNilView)
    }
    
    internal func updateContentsToList(list: List<T>) {
        self.list = list
        getDrawPoints()
        for subview in subviews {
            subview.removeFromSuperview()
        }
        addElements()
        setNeedsDisplay()
    }
    
    private func getDrawPoints() {
        points = []
        for i in 0..<list.size + 2 { //+head + last
            let point = ListNodePoint(index: i, position: CGPoint(x: elementWidth / 2 + CGFloat(i) * (elementWidth + spacingX), y: elementHeight + connectorHeight))
            points.append(point)
        }
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        for i in 0..<points.count - 1 {
            var deleted: Bool = points[i].deleted
            
            let startPointY: CGFloat = points[i].position.y - (deleted ? elementHeight : 0) //connector should be on top when deleted
            let startPoint: CGPoint = CGPoint(x: points[i].position.x, y: startPointY)
            
            let endPointIndex: Int = points[i].nextIndex
            let endPointY: CGFloat = points[endPointIndex].position.y - (deleted ? elementHeight : 0)
            let endPoint: CGPoint = CGPoint(x: points[endPointIndex].position.x, y: endPointY)
            
            let middlePoint: CGPoint = CGPoint(x: startPoint.x + (endPoint.x - startPoint.x) / 2, y: deleted ? connectorHeight - connectorHeight * 1.5 : elementHeight + connectorHeight * 2.5)
            
            
            //connect the two boxes
            let path: UIBezierPath = UIBezierPath()
            deleted ? deletedLineColor.setStroke() : lineColor.setStroke()
            path.lineWidth = 3
            path.move(to: startPoint)
            path.addQuadCurve(to: endPoint, controlPoint: middlePoint)
            path.stroke()
            
            
            //add arrow to connector
            let pathArrows = UIBezierPath()
            pathArrows.lineWidth = 2.5
            
            let a: CGFloat = abs(endPoint.x - middlePoint.x) / 2
            let b: CGFloat = abs(endPoint.y - middlePoint.y) / 1.5
            let c: CGFloat = sqrt(a*a+b*b)
            
            let arrowLength: CGFloat = 25
            
            func drawArrowLine(startPoint: CGPoint) {
                
                let d: CGFloat = abs(endPoint.x - startPoint.x)
                let e: CGFloat = abs(endPoint.y - startPoint.y)
                let f: CGFloat = sqrt(d*d+e*e)
                let div = f / arrowLength
                pathArrows.move(to: endPoint)
                pathArrows.addLine(to: CGPoint(x: endPoint.x - d / div, y: endPoint.y + (deleted ? -e / div : e / div)))
            }
            
            drawArrowLine(startPoint: CGPoint(x: middlePoint.x + 1.2 * a, y: middlePoint.y)) //1.2 changes the angle
            drawArrowLine(startPoint: CGPoint(x: middlePoint.x, y: middlePoint.y + (deleted ? 1.2 * b : -1.2 * b)))
            
            pathArrows.stroke()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
