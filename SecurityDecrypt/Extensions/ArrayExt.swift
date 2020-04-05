
import Foundation

extension Array where Element == Character {
    func map<T>(completion: ([Character]) -> T) -> T {
        completion(self)
    }
}
