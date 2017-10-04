import Foundation
import CoreGraphics

public struct ListNodePoint {
    
    internal let index: Int
    internal let position: CGPoint
    internal var nextIndex: Int
    internal var prevIndex: Int
    internal var deleted: Bool = false
    
    init(index: Int, position: CGPoint) {
        self.index = index
        self.position = position
        self.nextIndex = index + 1
        self.prevIndex = index - 1
    }
}
