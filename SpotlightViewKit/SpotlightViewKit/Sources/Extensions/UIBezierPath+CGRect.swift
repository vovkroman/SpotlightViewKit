import UIKit

extension UIBezierPath {
    convenience init(arround rect: CGRect) {
        
        // define radius based on rect.size (arround current path)
        let radius = 0.5 * sqrt(pow(rect.width, 2.0) + pow(rect.height, 2.0))
        self.init(arcCenter: rect.center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
    }
    
    var boundingBox: CGRect {
        return cgPath.boundingBoxOfPath
    }
}
