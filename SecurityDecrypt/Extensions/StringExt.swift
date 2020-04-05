
import Foundation

// MARK: - Parsers

extension String {
    
    var array: [Character] {
        Array(self)
    }
    
    var crypt: Crypt {
        .init(self)
    }
}

// MARK: - Formatters

public extension String {
    /// retorna apenas os caracteres alphanumericos
    var alphanumeric: String {
        self.components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined()
    }
}
