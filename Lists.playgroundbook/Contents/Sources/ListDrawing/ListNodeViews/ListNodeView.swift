import Foundation
import UIKit

internal class ListNodeView: UIView {
    
    private var index: Int
    private var timer: Timer!
    private let delegate: ListNodeDelegate?
    private var isDeleted: Bool = false
    private let progressColor: UIColor
    private var deleteProgress: Double = 0
    
    init(frame: CGRect, text: String, backgroundColor: UIColor = UIColor.blue, textColor: UIColor = UIColor.white, progressColor: UIColor = UIColor.white, index: Int, delegate: ListNodeDelegate? = nil) {
        self.index = index
        self.delegate = delegate
        self.progressColor = progressColor
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        let listNodeViewLabel = ListNodeViewLabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), text: text, textColor: textColor)
        addSubview(listNodeViewLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func timerUpdated() {
        deleteProgress = deleteProgress + 0.03
        if deleteProgress >= 1 && !isDeleted {
            isDeleted = true
            deleteProgress = 0
            timer.invalidate()
            alpha = 0.5
            delegate?.deleteListElement(atIndex: index)
        }
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isDeleted) {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerUpdated), userInfo: nil, repeats: true)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetProgress()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetProgress()
    }
    
    private func resetProgress() {
        timer.invalidate()
        deleteProgress = 0
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2,y: frame.size.height / 2), radius: min(frame.size.width / 2 - 2, frame.size.height / 2 - 2), startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(-M_PI_2 + deleteProgress / 1 * M_PI * 2), clockwise: true)
        circlePath.lineWidth = 2
        progressColor.setStroke()
        circlePath.stroke()
    }
}

public protocol ListNodeDelegate {
    func deleteListElement(atIndex index: Int)
}
