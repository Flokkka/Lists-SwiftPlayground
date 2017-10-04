import Foundation
import UIKit


internal class ListNodeViewLabel: UILabel {
    
    init(frame: CGRect, text: String, textColor: UIColor) {
        super.init(frame: frame)
        self.textColor = textColor
        self.text = text
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
