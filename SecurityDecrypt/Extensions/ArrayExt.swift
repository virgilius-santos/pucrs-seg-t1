
import Foundation

extension Array where Element == Character {
    
    var string: String {
        String(self)
    }
    
    func map<T>(completion: ([Character]) -> T) -> T {
        completion(self)
    }
}
