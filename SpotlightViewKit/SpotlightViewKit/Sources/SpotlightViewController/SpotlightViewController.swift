import UIKit

public class SpotlightViewController: UIViewController {

    public weak var delegate: SpotlightDelegate?
    public var mode: BackgroundMode = .blur(configurator: .init())
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        debugPrint("SpotlightViewController has been removed")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var _view: SpotLightView {
        return self.view as! SpotLightView
    }
    
    public override func loadView() {
        let view = SpotLightView(frame: UIScreen.main.bounds, mode: mode)
        view.delegate = delegate
        view.updateLayers()
        self.view = view
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _view.updateLayers()
        _view.setupAppearance()
        _view.start()
    }
}
