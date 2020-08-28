
import Foundation
import UIKit

extension UITextView {
    func removeAllInset() {
        textContainer.lineBreakMode = .byWordWrapping
        textContainer.lineFragmentPadding = 0
        textContainerInset = .zero
        contentInset = .zero
        scrollIndicatorInsets = .zero
        contentOffset = .zero
    }
    
    var requiredHeight: CGFloat {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        textView.removeAllInset()
        textView.isScrollEnabled = isScrollEnabled
        textView.font = font
        textView.text = text
        textView.sizeToFit()
        let size = textView.systemLayoutSizeFitting(textView.frame.size, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultHigh)
        return size.height
    }
}
