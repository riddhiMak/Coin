
import UIKit

extension UILabel {
    var requiredWidth: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: frame.height))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.width
    }

    var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    func configure(textColor:UIColor?, font:UIFont?, text:String? = nil) {
        
        if let textColor = textColor {
            self.textColor = textColor
        }
        
        if let font = font {
            self.font = font
        }
        
        if let text = text {
            self.text = text
        }
    }
    
    func configure(attributedText:NSAttributedString?, textColor:UIColor?) {
        
        if let textColor = textColor {
            self.textColor = textColor
        }
        
        if let attributedText = attributedText {
            self.attributedText = attributedText
        }
    }
    
    func addTextSpacing(spacing: CGFloat, color: UIColor) {
        guard let text = text else { return }

        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: NSRange(location: 0, length: text.count))

        attributedText = attributedString
    }
}
