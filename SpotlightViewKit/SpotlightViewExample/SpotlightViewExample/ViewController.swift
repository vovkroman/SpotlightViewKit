import UIKit
import SpotlightViewKit

class ViewController: UIViewController {

    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var blueView: UIView!
    
    private var _spotlightManager: SpotlightManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let manager: SpotlightManager = .init(self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // to launch SpotLightView with 3s delay
            manager.start()
        }
        _spotlightManager = manager
    }
}

extension ViewController: SpotlightConfigurator {
    var delegate: SpotlightDelegate? { return self }
    var backgroundMode: BackgroundMode { return .color(configurator: .init()) }
}

extension ViewController: SpotlightDelegate {
    var contentView: UIView? {
        return navigationController?.view
    }
    
    func numberOfFocusItem() -> Int {
        return 5
    }
    
    func focusRect(at index: Int) -> CGRect {
        switch index {
        case 0,2:
            return view.convert(orangeView.frame, from: orangeView.superview)
        case 1:
            return view.convert(yellowView.frame, from: yellowView.superview)
        case 3:
            return view.convert(blueView.frame, from: blueView.superview)
        case 4:
            return view.convert(yellowView.frame, from: yellowView.superview)
        default:
            return .zero
        }
    }
    
    func spotlightView(_ spotlightView: SpotLightView, animationDidFinishedForItem item: FocusItem) {
    }
    
    func allAnimationsDidFinished() {
        _spotlightManager = nil
    }
    
    func spotlightView(_ spotlightView: SpotLightView, performActionForItem item: FocusItem) {
        spotlightView.subviews.forEach{ $0.removeFromSuperview() }
        let label = UILabel()
        label.isOpaque = true
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.alpha = 0.0
        
        let font = UIFont.systemFont(ofSize: 24)
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.gray
        shadow.shadowBlurRadius = 5
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white,
            .shadow: shadow
        ]
        switch item.index {
        case 0, 2:
            label.attributedText = NSAttributedString(string: "Centered View. it's been added to check how view will look like.",
                                                      attributes: attributes)
            label.layoutIfNeeded()
            let size = label.sizeThatFits(CGSize(width: 200.0, height: .greatestFiniteMagnitude))
            label.frame = CGRect(origin: CGPoint(x: item.focusedRectangle.minX, y: item.focusedRectangle.minY - size.height), size: size)
        case 1:
            label.attributedText = NSAttributedString(string: "Upper Right View. It's been added to check how view will look like. Color is yellow.",
                                                      attributes: attributes)
            label.layoutIfNeeded()
            let size = label.sizeThatFits(CGSize(width: item.focusedRectangle.minX, height: .greatestFiniteMagnitude))
            var frame: CGRect!
            if #available(iOS 11.0, *) {
                frame = CGRect(origin: CGPoint(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top), size: size)
            } else {
                frame = CGRect(origin: CGPoint(x: 10.0, y: 10.0), size: size)
            }
            label.frame = frame
        case 3:
            label.attributedText = NSAttributedString(string: "Lower Left View. it's been added to check how view will look like. Color is blue.",
                                                      attributes: attributes)
            label.layoutIfNeeded()
            let size = label.sizeThatFits(CGSize(width: view.bounds.width - item.focusedRectangle.width, height: .greatestFiniteMagnitude))
            label.frame = CGRect(origin: CGPoint(x: item.focusedRectangle.maxX, y: item.focusedRectangle.minY), size: size)
        case 4:
            label.attributedText = NSAttributedString(string: "Just a simple image. it's been added to take a look how Kit works with nested views",
                                                      attributes: attributes)
            label.layoutIfNeeded()
            let size = label.sizeThatFits(CGSize(width: item.focusedRectangle.minX, height: .greatestFiniteMagnitude))
            var frame: CGRect!
            if #available(iOS 11.0, *) {
                frame = CGRect(origin: CGPoint(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top), size: size)
            } else {
                frame = CGRect(origin: CGPoint(x: 10.0, y: 10.0), size: size)
            }
            label.frame = frame
        default:
            break
        }
        spotlightView.addSubview(label)
        UIView.animate(withDuration: 0.4) {
            label.alpha = 1.0
        }
    }
}


