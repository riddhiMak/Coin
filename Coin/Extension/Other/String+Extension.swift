

import Foundation
import CoreGraphics

extension String {
        
    var boolValue: Bool {
        return NSString(string: self).boolValue
    }
    
    var floatValue: CGFloat {
        return CGFloat((self as NSString).doubleValue)
    }
    
    var priceFormat: String{
        if let doubleValue = Double(self) {
            return String(format: "%.2f",doubleValue)
        }
        else{
            return ""
        }
    }
    
    var htmlDecoded: String {
        
        var str: String = ""
        do {
            if let data = self.data(using: .unicode) {
                str = try NSAttributedString(data: data, options: [
                    NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html
                ], documentAttributes: nil).string
                return str
            }
        } catch {
            return str
        }
        
        return str
        
//        let decoded = try? NSAttributedString(data: Data(utf8), options: [
//            .documentType: NSAttributedString.DocumentType.html,
//            .characterEncoding: String.Encoding.utf8.rawValue
//            ], documentAttributes: nil).string
//
//        return decoded ?? self
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
    
    func amPmTime(withFormat format: String = "HH:mm:ss")-> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: date)
        }
        else{
            return ""
        }
        
    }
    
    func toString(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> String?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        else{
            return nil
        }
    }
}


extension String{
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

extension String{
    
    
}
