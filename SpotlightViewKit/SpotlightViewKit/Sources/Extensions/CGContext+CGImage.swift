import UIKit

public enum CaptureQuality {
    case `default`
    case low
    case medium
    case high

    var imageScale: CGFloat {
        switch self {
        case .default, .high:
            return 0
        case .low, .medium:
            return  1
        }
    }

    var interpolationQuality: CGInterpolationQuality {
        switch self {
        case .default, .low:
            return .none
        case .medium, .high:
            return .default
        }
    }
}

extension CGContext {
    static func imageContext(in rect: CGRect, isOpaque opaque: Bool, quality: CaptureQuality) -> CGContext? {
        UIGraphicsBeginImageContextWithOptions(rect.size, opaque, quality.imageScale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        context.translateBy(x: -rect.origin.x, y: -rect.origin.y)
        context.interpolationQuality = quality.interpolationQuality

        return context
    }

    func makeImage(with blendColor: UIColor?, blendMode: CGBlendMode, size: CGSize) -> CGImage? {
        if let color = blendColor {
            setFillColor(color.cgColor)
            setBlendMode(blendMode)
            fill(CGRect(origin: .zero, size: size))
        }

        return makeImage()
    }
}
