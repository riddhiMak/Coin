
import Foundation
import UIKit
import QuartzCore


class DesignableView : UIView {
    
    var borderWidth: CGFloat = 0.0 {
        didSet{
            self.layer.borderWidth = borderWidth;
            self.layer.masksToBounds = true
        }
    }
    
    var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor;
        }
        
    }
    
    var cornerRadious: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadious;
            self.layer.masksToBounds = true
        }
    }
    
    var shadowColor: UIColor?{
        get {
            let uiColor = UIColor(cgColor: self.layer.shadowColor!)
            
            return uiColor
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
}

extension UIView {
    func setBorder(color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func setRounded(_ isRounded: Bool) {
        if isRounded {
            layer.cornerRadius = frame.height > frame.width ? frame.width / 2 : frame.height / 2
            layer.masksToBounds = true
        } else {
            layer.cornerRadius = 0
            layer.masksToBounds = false
        }
    }
    
    func setCornerRadius(_ cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    func addShadow(ofColor color: UIColor = .black, radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    // MARK: - Animations

    func fadeOut(withDuration duration: TimeInterval = 0.3, toAlpha alpha: CGFloat = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = alpha
        }, completion: completion)
    }

    func fadeIn(withDuration duration: TimeInterval = 0.3, toAlpha alpha: CGFloat = 1.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = alpha
        }, completion: completion)
    }

    // MARK: - Xib

    func fromXib() -> UIView {
        let name = String(describing: type(of: self))
        return Bundle(for: type(of: self)).loadNibNamed(name, owner: self, options: nil)![0] as! UIView
    }

    func loadFromXib() {
        let customView = fromXib()
        addSubview(customView)

        customView.frame = bounds
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}


