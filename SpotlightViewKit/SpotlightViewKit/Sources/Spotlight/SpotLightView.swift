import UIKit

public enum Event {
    case `init`
    case starting
    case loaded
    case executing(indexItem: Int)
    case finishing
}

public struct FocusItem {
    public let index: Int
    /// **focusRectangle** - is CGRect of the cut slot, (not view)
    public let focusedRectangle: CGRect
}

public enum BackgroundMode {
    case blur(configurator: BlurConfigurator)
    case color(configurator: ColorConfigurator)
}

public protocol SpotlightDelegate: class {
    func numberOfFocusItem() -> Int
    func focusRect(at index: Int) -> CGRect
    func spotlightView(_ spotlightView: SpotLightView, performActionForItem item: FocusItem)
    func spotlightView(_ spotlightView: SpotLightView, animationDidFinishedForItem item: FocusItem)
    func allAnimationsDidFinished()
}

public class SpotLightView: UIView {
    
    final public override class var layerClass: AnyClass {
        return SpotlightLayer.self
    }
    
    final public override var layer: SpotlightLayer {
        return super.layer as! SpotlightLayer
    }
    
    weak var delegate: SpotlightDelegate?
    
    /// Iterator through the single link list
    private var _iterator: FocusRectanglesIterator?
    
    private let _mode: BackgroundMode
    
    private(set) var _event: Event = .`init` {
        didSet {
            didUpdate(from: oldValue, to: _event)
        }
    }
        
    init(frame: CGRect, mode: BackgroundMode = .blur(configurator: .init())) {
        _mode = mode
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        _mode = .blur(configurator: .init())
        super.init(coder: coder)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        layer.removeAllAnimations()
        animate()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupBackground(on: _mode)
    }
    
    // MARK: - Public methods
    
    public func start() {
        guard let count = delegate?.numberOfFocusItem(), count > 0 else {
            return
        }
        _iterator = .init(count: count)
        _event = .starting
    }
    
    // MARK: - Private methods
    
    private func didUpdate(from: Event, to: Event) {
        #if DEBUG
        debugPrint("[SpotlightView]: \(#function) in \(#line) Transition state: \(from) -> \(to)")
        #endif
        switch (from, to) {
        case (.starting, .loaded), (.loaded, .starting):
            animate()
        case (.executing, .finishing):
            animateWrapup()
        case (_, .loaded):
            #if DEBUG
            debugPrint("[SpotlightView]: \(#function) in \(#line): please check if method 'start' has been invoked")
            #endif
        default:
            break
        }
    }
    
    private func animate() {
        guard let currentIndex = _iterator?.next() else {
            _event = .finishing
            return
        }
        _event = .executing(indexItem: currentIndex)
        performActionsForItem(at: currentIndex)
    }
    
    private func animateWrapup() {
        CATransaction.begin()
        if let delegate = delegate {
            CATransaction.setCompletionBlock(combine((), with: delegate.allAnimationsDidFinished))
        }
        layer.finish()
        CATransaction.commit()
    }
    
    private func performActionsForItem(at index: Int) {
        guard let delegate = delegate else { return }
        let nextRect = delegate.focusRect(at: index)
        let shapes = layer.drawShape(with: nextRect)
        let focusItem = FocusItem(index: index, focusedRectangle: shapes.inner.boundingBox)
        CATransaction.begin()
        CATransaction.setCompletionBlock(combine(self, focusItem, with: delegate.spotlightView(_:animationDidFinishedForItem:)))
        layer.moveAnimation(to: shapes.final.cgPath, delegate: nil)
        delegate.spotlightView(self, performActionForItem: focusItem)
        CATransaction.commit()
    }
    
    private func setupBackground(on displayMode: BackgroundMode) {
        if layer.contents == nil {
            guard let image = self.superview?.makeCapture() else { return }
            switch displayMode {
            case .blur(let config):
                let blurImage = image.applyBlur(radius: config.blurRadius,
                                                iterations: config.iterations,
                                                ratio: config.ratio,
                                                blendColor: config.blendColor,
                                                blendMode: config.blendMode)
                layer.contents = blurImage
            case .color(let config):
                let colorImage = image.apply(config.color,
                                             config.blendMode,
                                             config.alpha)
                layer.contents = colorImage.cgImage
            }
            _event = .loaded
        }
    }
}
