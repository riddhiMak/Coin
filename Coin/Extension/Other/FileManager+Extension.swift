
import Foundation

extension FileManager{
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let templateDirectory = FileManager.documentDirectory.appendingPathComponent("Template")
}


