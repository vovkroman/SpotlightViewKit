import UIKit

public protocol SpotlightConfigurator {
    var delegate: SpotlightDelegate? { get }
    var backgroundMode: BackgroundMode { get }
}

public class SpotlightManager {
    
    private lazy var _window: UIWindow = .init(frame: UIScreen.main.bounds)
    
    private weak var _delegate: SpotlightDelegate?
    private let _backgroundMode: BackgroundMode
    
    public func start() {
        let viewController = SpotlightViewController()
        viewController.mode = _backgroundMode
        viewController.delegate = self
        _window.rootViewController = viewController
        _window.makeKeyAndVisible()
    }
    
    public init(_ config: SpotlightConfigurator) {
        _delegate = config.delegate
        _backgroundMode = config.backgroundMode
    }
    
    deinit {
        debugPrint("Spotlight manager has been removed")
    }
}

extension SpotlightManager: SpotlightDelegate {
    public var contentView: UIView? {
        return _delegate?.contentView
    }
    
    public func numberOfFocusItem() -> Int {
        return _delegate?.numberOfFocusItem() ?? 0
    }
    
    public func focusRect(at index: Int) -> CGRect {
        return _delegate?.focusRect(at: index) ?? .zero
    }
    
    public func spotlightView(_ spotlightView: SpotLightView, performActionForItem item: FocusItem) {
        _delegate?.spotlightView(spotlightView, performActionForItem: item)
    }
    
    public func spotlightView(_ spotlightView: SpotLightView, animationDidFinishedForItem item: FocusItem) {
        _delegate?.spotlightView(spotlightView, animationDidFinishedForItem: item)
    }
    
    public func allAnimationsDidFinished() {
        _delegate?.allAnimationsDidFinished()
        _window.rootViewController = nil
        _window.resignKey()
        let mainWindow = UIApplication.shared.windows.first
        mainWindow?.makeKeyAndVisible()
    }
}
