
import Foundation

// MARK: - Parsers

extension String {
    /// transforma  uma string em um array de caracteres
    var array: [Character] {
        Array(self)
    }

    /// transforma  uma string em um Crypt
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
