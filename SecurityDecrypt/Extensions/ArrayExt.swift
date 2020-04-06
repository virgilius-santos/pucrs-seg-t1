
import Foundation

// MARK: - Parsers

extension Array where Element == Character {
    /// transforma um array de caracteres em  uma string
    var string: String {
        String(self)
    }
    
    /// permite passar uma função para transformar um array de caracteres em outro tipo
    func map<T>(completion: ([Character]) -> T) -> T {
        completion(self)
    }
}

// MARK: - Counters

extension Array where Element == Character {
    /// conta a frequencia de cada caracter da string
    /// retorna um dicionario com os caracteres e suas quantidades
    func frequencies(step: Int = 1) -> [[Character: Int]] {
        stride(from: .zero, to: step, by: 1)
            .map { (start: Int) -> [Character: Int] in
                stride(from: start, to: count, by: Swift.max(step, 1))
                    .reduce(into: [Character: Int]()) { dict, value in
                        dict[self[value]] = (dict[self[value]] ?? 0) + 1
                    }
            }
    }
}
