import UIKit

extension UIImage {
    func applyBlur(radius: CGFloat, iterations: Int, ratio: CGFloat, blendColor color: UIColor?, blendMode mode: CGBlendMode) -> CGImage? {
        guard let cgImage = cgImage else {
            return nil
        }
        if cgImage.area <= 0 || radius <= 0 {
            return cgImage
        }
        var boxSize = UInt32(radius * scale * ratio)
        if boxSize % 2 == 0 {
            boxSize += 1
        }
        return cgImage.blurred(with: boxSize, iterations: iterations, blendColor: color, blendMode: mode)
    }
}
