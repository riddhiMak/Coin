

import Foundation
import UIKit

class DesignableButton: UIButton {
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
   
    var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
        if rounded {
            self.layer.masksToBounds = true
        }
    }
}

extension UIButton{
    
    func configure(textColor:UIColor?, font:UIFont?, title:String? = nil, image:UIImage? = nil) {
        
        if let textColor = textColor {
            
            if buttonType == .system {
                tintColor = textColor
            }
            else{
                setTitleColor(textColor, for: .normal)
            }
        }
        
        if let font = font {
            titleLabel?.font = font
        }
        
        setTitle(title, for: .normal)
        
        if let image = image{
            setImage(image, for: .normal)
        }
    }
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        clipsToBounds = true

        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))

        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            setBackgroundImage(colorImage, for: forState)
        }
    }
}
