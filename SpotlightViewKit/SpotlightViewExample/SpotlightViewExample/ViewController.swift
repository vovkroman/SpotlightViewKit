import UIKit
import SpotlightViewKit

class ViewController: UIViewController {

    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var blueView: UIView!
    
    private var _spotlightView: SpotLightView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurConfig = BlurConfigurator(1.0,
                                          blurRadius: 20.0,
                                          blendColor: .darkGray,
                                          blendMode: .luminosity,
                                          iterations: 3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let spotLight = SpotLightView(frame: UIScreen.main.bounds, mode: .blur(configurator: blurConfig))
            self._spotlightView = spotLight
            spotLight.delegate = self
            spotLight.start()
            self.view.addSubview(spotLight)
        }
    }
}

extension ViewController: SpotlightDelegate {
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
        _spotlightView?.removeFromSuperview()
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
            label.attributedText = NSAttributedString(string: "Cenetered View. it's been added to check how view wil look like.",
                                                      attributes: attributes)
            label.layoutIfNeeded()
            let size = label.sizeThatFits(CGSize(width: 200.0, height: .greatestFiniteMagnitude))
            label.frame = CGRect(origin: CGPoint(x: item.focusedRectangle.minX, y: item.focusedRectangle.minY - size.height), size: size)
        case 1:
            label.attributedText = NSAttributedString(string: "Upper Letf View. it's been added to check how view will look like. Color is blue",
                                                      attributes: attributes)
            label.layoutIfNeeded()
            let size = label.sizeThatFits(CGSize(width: item.focusedRectangle.minX, height: .greatestFiniteMagnitude))
            label.frame = CGRect(origin: CGPoint(x: 10.0, y: 10.0), size: size)
        case 3:
            label.attributedText = NSAttributedString(string: "Lower Right View. it's been added to check how view will look like. Color is purple",
                                                      attributes: attributes)
            label.layoutIfNeeded()
            let size = label.sizeThatFits(CGSize(width: view.bounds.width - item.focusedRectangle.width, height: .greatestFiniteMagnitude))
            label.frame = CGRect(origin: CGPoint(x: item.focusedRectangle.maxX, y: item.focusedRectangle.minY), size: size)
        case 4:
            label.attributedText = NSAttributedString(string: "Just a simple image. it's been added how Kit works with nested views",
                                                      attributes: attributes)
            label.layoutIfNeeded()
            let size = label.sizeThatFits(CGSize(width: item.focusedRectangle.minX, height: .greatestFiniteMagnitude))
            label.frame = CGRect(origin: CGPoint(x: 10.0, y: 10.0), size: size)
        default:
            break
        }
        spotlightView.addSubview(label)
        UIView.animate(withDuration: 0.4) {
            label.alpha = 1.0
        }
    }
}


