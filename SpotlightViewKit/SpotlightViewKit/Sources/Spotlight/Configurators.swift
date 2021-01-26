import UIKit

public struct ColorConfigurator {
    
    /// Color
    public let color: UIColor
    
    /// Blended Mode
    public let blendMode: CGBlendMode
    
    /// Alpha [0;1]
    public let alpha: CGFloat
    
    public init(_ color: UIColor = .gray,
                blendMode: CGBlendMode = .color,
                alpha: CGFloat = 0.6) {
        self.color = color
        self.blendMode = blendMode
        self.alpha = alpha
    }
}

public struct BlurConfigurator {
    /// Ratio
    public let ratio: CGFloat
    
    ///Blur radius
    public let blurRadius: CGFloat
    
    /// Blend color.
    public let blendColor: UIColor?
    
    /// Blend mode.
    public let blendMode: CGBlendMode
    
    /// Default is 3.
    public let iterations: Int
    
    public init(_ ratio: CGFloat = 1.0,
                blurRadius: CGFloat = 5.0,
                blendColor: UIColor? = .gray,
                blendMode: CGBlendMode = .darken,
                iterations: Int = 3) {
        self.ratio = ratio
        self.blurRadius = blurRadius
        self.blendColor = blendColor
        self.blendMode = blendMode
        self.iterations = iterations
    }
}
