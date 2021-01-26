import UIKit

extension UIView {
    /// Make snapshot of the current view (draw context inside current)
    /// - Returns: return UIImage of current view
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
