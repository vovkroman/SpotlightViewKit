import UIKit

public class AnimationBuilder {
    private let _animation: CABasicAnimation
    
    @discardableResult
    public func duration(duration: TimeInterval) -> AnimationBuilder {
        _animation.duration = duration
        return self
    }
    
    @discardableResult
    public func timingFunction(timingFunction: CAMediaTimingFunction) -> AnimationBuilder {
        _animation.timingFunction = timingFunction
        return self
    }
    
    @discardableResult
    public func edgeValues(from: Any?, to: Any?) -> AnimationBuilder {
        _animation.fromValue = from
        _animation.toValue = to
        return self
    }
    
    @discardableResult
    public func fillMode(fillMode: CAMediaTimingFillMode) -> AnimationBuilder {
        _animation.fillMode = fillMode
        return self
    }
    
    @discardableResult
    public func begin(from: TimeInterval) -> AnimationBuilder {
        _animation.beginTime = from
        return self
    }
    
    @discardableResult
    public func setDelegate(_ delegate: CAAnimationDelegate?) -> AnimationBuilder {
        _animation.delegate = delegate
        return self
    }
    
    @discardableResult
    public func removedAnimtion(isRemoved: Bool = false) -> AnimationBuilder {
        _animation.isRemovedOnCompletion = isRemoved
        return self
    }
    
    public func build() -> CABasicAnimation {
        return _animation
    }
    
    public init(with keyPath: String) {
        _animation = CABasicAnimation(keyPath: keyPath)
    }
}
