import Foundation
import UIKit

internal class ListNodeNilView: UIView {
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //draw red cross
        let path: UIBezierPath = UIBezierPath()
        UIColor.red.setStroke()
        path.lineWidth = rect.size.width / 15
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height))
        path.move(to: CGPoint(x: 0, y: frame.size.height))
        path.addLine(to: CGPoint(x: frame.size.width, y: 0))
        path.stroke()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

