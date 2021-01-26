import UIKit

extension UIBezierPath {
    /// Init **round** UIBezierPath, relyed on rect
    /// - Parameter rect: CGRect, arround which UIBezierPath has been initied
    convenience init(arround rect: CGRect) {
        
        // define radius based on rect.size (arround current path)
        let radius = 0.5 * sqrt(pow(rect.width, 2.0) + pow(rect.height, 2.0))
        self.init(arcCenter: rect.center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
    }
    
    /// boundingBox arround UIBezierPath
    var boundingBox: CGRect { return cgPath.boundingBoxOfPath }
}
