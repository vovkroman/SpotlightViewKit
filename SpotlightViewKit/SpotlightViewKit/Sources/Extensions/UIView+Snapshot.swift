import UIKit

extension UIView {
    func makeCapture() -> UIImage? {
        let config = UIGraphicsImageRendererFormat()
        config.opaque = isOpaque
        let render = UIGraphicsImageRenderer(bounds: bounds,
                                             format: config)
        // And finally, get image
        let image = render.image { ctx in
            layer.render(in: ctx.cgContext)
        }
        return image
    }
}
