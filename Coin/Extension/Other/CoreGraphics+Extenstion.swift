
import Foundation
import CoreGraphics

extension CGRect {
    
    func multiply(point:CGPoint) -> CGRect {
        
        return CGRect(x: self.minX * point.x,
                      y: self.minY * point.y,
                      width: self.width * point.x,
                      height: self.height * point.y)
    }
    
    var center :CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}

extension CGSize {
    
    func multiply(point:CGPoint) -> CGSize {
        
        return CGSize(width: self.width * point.x,
                      height: self.height * point.y)
    }
}

extension CGAffineTransform {
    
    var angle :CGFloat{
        return CGFloat(atan2f(Float(self.b), Float(self.a)))
    }
}

extension CGPoint {
    
    func distance(to point:CGPoint) -> CGFloat {
        
        let fx = point.x - self.x
        let fy = point.y - self.y
        
        return CGFloat(sqrtf(Float(fx*fx + fy*fy)))
    }
    
    func multiply(point:CGPoint) -> CGPoint {
        
        return CGPoint(x: self.x * point.x,
                      y: self.y * point.y)
    }
}
