
import Foundation

extension Double {
    /// permite passar uma função para transformar um double em outro tipo
    func map<T>(_ closure: (Double) -> T) -> T {
        return closure(self)
    }
}

extension Int {
    /// permite passar uma função para transformar um int em outro tipo
    func map<T>(_ closure: (Int) -> T) -> T {
        return closure(self)
    }
}
