
import Foundation

extension Dictionary where Key == String, Value == Int {
    var total: Int {
        values.reduce(0, +)
    }
}
