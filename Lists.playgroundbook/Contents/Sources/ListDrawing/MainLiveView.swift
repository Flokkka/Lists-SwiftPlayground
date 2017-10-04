import Foundation
import UIKit
import PlaygroundSupport

public class MainLiveView<T: Equatable>: UIScrollView, PlaygroundLiveViewMessageHandler {
    
    private var listContainerView = ListDrawingContainerView<T>()
    private var heightConstraint: NSLayoutConstraint!
    private var didUpdateSubviews = false
    
    public init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
        
        self.translatesAutoresizingMaskIntoConstraints = false
        listContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(listContainerView)
        
        let margins = self.layoutMarginsGuide
        listContainerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0).isActive = true
        listContainerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0).isActive = true
        heightConstraint = NSLayoutConstraint(item: listContainerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        addConstraint(heightConstraint)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsLayout()
        listContainerView.setNeedsDisplay()

        if !didUpdateSubviews {
            didUpdateSubviews = true
            updateContainerView()
        }
    }
    
    public func show(_ list: List<T>) {
        listContainerView.show(list)
    }
    
    public func updateContainerView() {
        self.contentSize = CGSize(width: 0, height: listContainerView.contentHeight)
        for subview in listContainerView.subviews {
            subview.removeFromSuperview()
        }
        heightConstraint.constant = contentSize.height
        listContainerView.draw()
    }
    
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case let .string(message):
            //send list to LiveViewListener
            let data = NSKeyedArchiver.archivedData(withRootObject: listContainerView.lists.last!)
            send(.data(data))
            break
        case let .data(message):
            let list = NSKeyedUnarchiver.unarchiveObject(with: message) as! List<T>
            show(list)
            updateContainerView()
            break
        default: break
        }
    }
    
}
