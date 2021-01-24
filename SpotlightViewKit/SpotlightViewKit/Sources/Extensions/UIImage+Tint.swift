import UIKit

extension UIImage {
    func apply(_ tintColor: UIColor, _ blendMode: CGBlendMode, _ alpha: CGFloat) -> UIImage {
        let config = UIGraphicsImageRendererFormat()
        config.opaque = true
        let render = UIGraphicsImageRenderer(size: size, format: config)
        let bounds = CGRect(origin: .zero, size: size)

        // And finally, get image
        let image = render.image { ctx in
            tintColor.set()
            ctx.fill(bounds)
            draw(in: bounds, blendMode: blendMode, alpha: alpha)
        }
        return image
    }
}
