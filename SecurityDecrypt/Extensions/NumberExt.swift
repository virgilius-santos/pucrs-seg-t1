
import Foundation

extension Double {
    
    /// permite passar uma função para transformar uma double em outra variavel
    func map<T>(_ closure: (Double) -> T) -> T {
        return closure(self)
    }
}

extension Int {
    /// permite passar uma função para transformar uma double em outra variavel
    func map<T>(_ closure: (Int) -> T) -> T {
        return closure(self)
    }
}

extension String {
    /// permite passar uma função para transformar uma double em outra variavel
    func map<T>(_ closure: (String) -> T) -> T {
        return closure(self)
    }
}
