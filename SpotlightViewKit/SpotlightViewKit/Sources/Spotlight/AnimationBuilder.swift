import UIKit

class AnimationBuilder {
    private let _animation: CABasicAnimation
    
    @discardableResult
    func duration(duration: TimeInterval) -> AnimationBuilder {
        _animation.duration = duration
        return self
    }
    
    @discardableResult
    func timingFunction(timingFunction: CAMediaTimingFunction) -> AnimationBuilder {
        _animation.timingFunction = timingFunction
        return self
    }
    
    @discardableResult
    func edgeValues(from: Any?, to: Any?) -> AnimationBuilder {
        _animation.fromValue = from
        _animation.toValue = to
        return self
    }
    
    @discardableResult
    func fillMode(fillMode: CAMediaTimingFillMode) -> AnimationBuilder {
        _animation.fillMode = fillMode
        return self
    }
    
    @discardableResult
    func begin(from: TimeInterval) -> AnimationBuilder {
        _animation.beginTime = from
        return self
    }
    
    @discardableResult
    func setDelegate(_ delegate: CAAnimationDelegate?) -> AnimationBuilder {
        _animation.delegate = delegate
        return self
    }
    
    @discardableResult
    func removedAnimtion(isRemoved: Bool = false) -> AnimationBuilder {
        _animation.isRemovedOnCompletion = isRemoved
        return self
    }
    
    func build() -> CABasicAnimation {
        return _animation
    }
    
    init(with keyPath: String) {
        _animation = CABasicAnimation(keyPath: keyPath)
    }
    
    
}
