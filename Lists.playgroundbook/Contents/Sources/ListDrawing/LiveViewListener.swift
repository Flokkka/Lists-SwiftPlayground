import Foundation
import PlaygroundSupport


public class LiveViewListener<T: Equatable>: PlaygroundRemoteLiveViewProxyDelegate {
    
    public let dispatchGroup = DispatchGroup()
    
    public init() {}
    
    public var list: List<T>! {
        didSet {
            dispatchGroup.leave()
        }
    }
    
    public func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy, received message: PlaygroundValue) {
        switch message {
        case let .data(message):
            list = NSKeyedUnarchiver.unarchiveObject(with: message) as! List<T>
            break
        default: break
        }
    }
    
    public func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) {}
}
