
import Foundation

class Read {
    func read(_ file: String, format: String) throws -> String? {
        if let path = bundle.path(forResource: file, ofType: format) {
            return try String(contentsOfFile: path, encoding: .utf8)
        }
        return nil
    }
}
