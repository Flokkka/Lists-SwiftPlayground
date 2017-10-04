import Foundation
import UIKit

internal class ListNodeHead: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        let label = ListNodeViewLabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), text: "Head", textColor: UIColor.white)
        addSubview(label)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
