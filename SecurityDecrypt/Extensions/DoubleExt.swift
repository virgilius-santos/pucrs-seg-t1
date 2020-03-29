
import Foundation

extension Double {
    func map<T>(_ closure: (Double) -> T) -> T {
        return closure(self)
    }
}
