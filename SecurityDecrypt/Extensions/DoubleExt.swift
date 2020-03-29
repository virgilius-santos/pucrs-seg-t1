
import Foundation

extension Double {
    
    /// permite passar uma função para transformar uma double em outra variavel
    func map<T>(_ closure: (Double) -> T) -> T {
        return closure(self)
    }
}
