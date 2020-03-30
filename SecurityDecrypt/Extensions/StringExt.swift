
import Foundation

// MARK: Vigenere Encrypt

extension String {
    /// faz a encriptacao usando a chave que foi passada
    func encrypt(key: String) -> String {
        stride(from: 0, to: count, by: key.count)
            .map { (i: Int) -> String in encrypt(i: i, key: key) }
            .reduce("", +)
    }
    
    /// faz a encriptacao usando a chave que foi passada
    /// pegando as letras da String a partir da variavel i informada
    func encrypt(i: Int, key: String) -> String {
        stride(from: 0, to: key.count, by: 1)
            .filter { (j: Int) -> Bool in (i + j) < self.count }
            .map { (Array(key.lowercased())[$0], Array(self)[i + $0]) }
            .compactMap { Crypt.char(key: $0, fromValue: $1) }
            .map { (c: Character) -> String in String(c) }
            .reduce("", +)
    }
}

// MARK: Vigenere Decrypt

extension String {
    /// faz a decriptacao usando a chave que foi passada
    func decrypt(key: String) -> String {
        stride(from: 0, to: count, by: key.count)
            .map { (i: Int) -> String in decrypt(i: i, key: key) }
            .reduce("", +)
    }
    
    /// faz a decriptacao usando a chave que foi passada
    /// pegando as letras da String a partir da variavel i informada
    func decrypt(i: Int, key: String) -> String {
        stride(from: 0, to: key.count, by: 1)
            .filter { (j: Int) -> Bool in (i + j) < self.count }
            .map { (Array(key.lowercased())[$0], Array(self)[i + $0]) }
            .compactMap { Crypt.char(key: $0, fromAlphabet: $1) }
            .map { (c: Character) -> String in String(c) }
            .reduce("", +)
    }
}

// MARK: Index of coincidence

extension String {
    /// calcula o indice de coincidencia da String usando a frequencia dos caracteres
    func indexOfCoincidence() -> Double {
        let frequencies: [String: Int] = self.frequencies()
        let total: Int = frequencies.total
        let const: Int = total * (total - 1)
        let values: [Int] = frequencies.values.map { $0 }
        
        guard const > .zero else { return .zero }
        
        let sum: Int = values.reduce(.zero) { $0 + ($1 * ($1 - 1)) }
        return Double(sum) / Double(const)
    }
    
    /// quebra a string em substrings usando o step
    /// depois cacula o indice de coincidencia de cada substrings
    func indexOfCoincidence(step: Int) -> Double {
        substrings(step: step)
            .reduce(Double.zero) { $0 + $1.indexOfCoincidence() }
            .map { $0 / Double(step) }
    }
    
    /// de acordo com a qtd informada gera uma serie de indices de coincidencia variando o step
    func generateIndexOfCoincidence(qtd: Int) -> [Double] {
        stride(from: 1, to: qtd + 1, by: 1)
            .map { indexOfCoincidence(step: $0) }
    }
    
    /// gera dez indiecs de coincidencia e retorna o seu step
    func findStepOfIndexOfCoincidence() -> Int {
        let coeficient: Double = 0.0667
        let ic = self.generateIndexOfCoincidence(qtd: 10)
            .enumerated()
            .first(where: { $0.element.distance(to: coeficient) < 0.001 })?
            .offset
        
        return 1 + (ic ?? .zero)
    }
}

// MARK: Split String

extension String {
    /// permite retornar uma substring com um range passado.
    /// ex. "palavra"[2..<4] = "la"
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(.zero, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    
    /// retorna um caracter da string de acordo com o index
    /// se o index for invalido retorna nil
    subscript(safe index: Int) -> String? {
        guard index >= .zero, index < count else { return nil }
        return String(Array(self)[index])
    }
    
    /**
     retorna um conjunto de substrings pulando os caracteres de acordo com o step
     ex. "banana".substring(step: 2) == ["bnn", "aaa"]
     
     - parameter step: indica quantas casas ira pular até pegar o próximo caracter
     */
    func substrings(step: Int) -> [String] {
        stride(from: .zero, to: step, by: 1)
            .map { i in substring(start: i, step: step) }
    }
    
    /**
     retorna uma substring pulando os caracteres de acordo com o step
     ex. "banana".substring(start 1, step: 2) == "aaa"
     
     - parameter start: indica onde a substring irá começar
     - parameter step: indica quantas casas ira pular até pegar o próximo caracter
     */
    func substring(start: Int = .zero, step: Int = 1) -> String {
        stride(from: start, to: count, by: step)
            .compactMap { i in self[safe: i] }
            .reduce("", +)
    }
}

// MARK: Counters

extension String {
    /// conta a frequencia de cada caracter da string
    /// retorna um dicionario com os caracteres e suas quantidades
    func frequencies() -> [String: Int] {
        reduce(into: [String: Int]()) { dict, value in
            let str = String(value)
            dict[str] = (dict[str] ?? 0) + 1
        }
    }
}

// MARK: Formatters

public extension String {
    /// retorna apenas os caracteres alphanumericos
    var alphanumeric: String {
        self.components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined()
    }
}
