
import Foundation
import UIKit

class DesignableTextfield: UITextField {
    var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth;
        }
    }
    
    var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor;
        }
    }
    
    var cornerRadious: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadious;
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UITextField{
    
    func configure(textColor:UIColor?, font:UIFont?, placeHolderText:String? = nil) {
        
        if let textColor = textColor {
            self.textColor = textColor
        }
        
        if let font = font {
            self.font = font
        }
        
        if let placeHolderText = placeHolderText {
            self.placeholder = placeHolderText
        }
    }
}
