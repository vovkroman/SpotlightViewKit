import UIKit

enum Animation: String {
    case move = "Move focus"
    case text = "Animate text"
}

typealias UIBezierPathes = (inner: UIBezierPath, final: UIBezierPath)

protocol Shapable {
    func drawShape(with rect: CGRect) -> UIBezierPathes
}

enum Constants {
    static let duration: TimeInterval = 1.0
}

public class SpotlightLayer: CALayer {
    
    private unowned var _masklayer: CAShapeLayer!
    
    private var _initialPath: UIBezierPath {
        let outerPath = UIBezierPath(rect: bounds)
        let innerPath = UIBezierPath(arround: bounds)
        let shapeLayerPath = UIBezierPath()
        shapeLayerPath.append(outerPath)
        shapeLayerPath.append(innerPath)
        return shapeLayerPath
    }
    
    // MARK: - Life Cycle of CALayer
    
    public override init() {
        super.init()
        _setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        _setup()
    }
    
    public override func removeAllAnimations() {
        super.removeAllAnimations()
        _masklayer.removeAnimation(forKey: Animation.move.rawValue)
    }
    
    // MARK: - Public methods
    
    public func updateLayers() {
        _masklayer.frame = bounds
        _masklayer.path = _initialPath.cgPath
    }
    
    public func finish() {
        moveAnimation(to: _initialPath.cgPath, delegate: nil)
    }
    
    public func moveAnimation(to: CGPath, delegate: CAAnimationDelegate?) {
        let focusAnimation = AnimationBuilder(with: #keyPath(CAShapeLayer.path))
            .begin(from: 0.0)
            .duration(duration: Constants.duration)
            .edgeValues(from: _masklayer.presentation()?.path, to: to)
            .timingFunction(timingFunction: CAMediaTimingFunction(name: .easeInEaseOut))
            .fillMode(fillMode: .forwards)
            .removedAnimtion()
            .build()
        _masklayer.add(focusAnimation, forKey: Animation.move.rawValue)
    }
    
    // MARK: - Private methods
    
    private func _setup() {
        contentsScale = UIScreen.main.scale
        let shapelayer = CAShapeLayer()
        shapelayer.path = _initialPath.cgPath
        
        ///**Fill rules** captured CAShapeLayer, which been added as mask
        shapelayer.fillRule = .evenOdd
        mask = shapelayer
        _masklayer = shapelayer
    }
}

extension Shapable where Self: CALayer {
    func drawShape(with rect: CGRect) -> UIBezierPathes {
        let outerPath = UIBezierPath(rect: bounds)
        let innerPath = UIBezierPath(arround: rect)
        let shapeLayerPath = UIBezierPath()
        shapeLayerPath.append(outerPath)
        shapeLayerPath.append(innerPath)
        return (innerPath, shapeLayerPath)
    }
}

extension SpotlightLayer: Shapable {}
