
import Foundation

// MARK: - Vigenere Encrypt

extension String {
    /// faz a encriptacao usando a chave que foi passada
    func encrypt(key: String) -> String {
        let selfArray: [Character] = Array(self)
        let keyArray: [Character] = Array(key)
        return stride(from: 0, to: count, by: key.count)
            .flatMap { (i: Int) -> [Character] in
                encrypt(key: keyArray,
                        slice: selfArray[i ..< min(i + key.count, selfArray.count)],
                        i)
            }
            .map { (c: Character) -> String in
                String(c)
            }
            .reduce("", +)
    }

    /// faz a encriptacao usando a chave que foi passada
    /// pegando as letras da String a partir da variavel i informada
    func encrypt(key: [Character], slice: ArraySlice<Character>, _ j: Int) -> [Character] {
        slice
            .enumerated()
            .compactMap { (i: Int, c: Character) -> Character? in
                Crypt.matrizVigenere[key[i]]?[c]
            }
    }
}

// MARK: - Vigenere Decrypt

extension String {
    /// faz a decriptacao usando a chave que foi passada
    func decrypt(key: [Character]) -> String {
        print("------", key, "------")
        let selfArray: [Character] = Array(self)
        let keyArray: [Character] = key
        return stride(from: 0, to: count, by: key.count)
            .flatMap { (i: Int) -> [Character] in
                decrypt(key: keyArray,
                        slice: selfArray[i ..< min(i + key.count, selfArray.count)],
                        i)
        }
        .map { (c: Character) -> String in
            String(c)
        }
        .reduce("", +)
    }

    /// faz a decriptacao usando a chave que foi passada
    /// pegando as letras da String a partir da variavel i informada
    func decrypt(key: [Character], slice: ArraySlice<Character>, _ j: Int) -> [Character] {
        slice
            .enumerated()
            .compactMap { (i: Int, c: Character) -> Character? in
                Crypt.matrizVigenereInverted[key[i]]?[c]
            }
    }
}

// MARK: - Index of coincidence

/// quebra a string em substrings usando o step
/// depois cacula o indice de coincidencia de cada substrings
func indexOfCoincidence(step: Int, selfArray: [Character]) -> Double {
    substrings(step: step, selfArray: selfArray)
        .reduce(Double.zero) { (old: Double, word: [Character]) -> Double in
            old + indexOfCoincidence(selfArray: word)
    }
    .map { (v: Double) -> Double in
        v / Double(step)
    }
}

/// calcula o indice de coincidencia da String usando a frequencia dos caracteres
func indexOfCoincidence(selfArray: [Character]) -> Double {
    let freqs: [Character: Int] = frequencies(selfArray: selfArray)
    let total: Int = freqs.total
    let const: Int = total * (total - 1)
    let values: [Int] = freqs.values.map { $0 }
    
    guard const > .zero else { return .zero }
    
    let sum: Int = values
        .reduce(.zero) { (old: Int, new: Int) -> Int in
            old + (new * (new - 1))
    }
    return Double(sum) / Double(const)
}

/// de acordo com a qtd informada gera uma serie de indices de coincidencia variando o step
func generateIndexOfCoincidence(qtd: Int, selfArray: [Character]) -> [Double] {
    stride(from: 1, to: qtd + 1, by: 1)
        .map { (i: Int) -> Double in
            indexOfCoincidence(step: i, selfArray: selfArray)
    }
}

extension String {

    /// gera dez indiecs de coincidencia e retorna o primeiro indice do mais proximo ao valor default 0.0667
    func findFirstClosestndexOfCoincidence() -> Int {
        (generateIndexOfCoincidence(qtd: 10, selfArray: array)
            .enumerated()
            .first(where: { (v: EnumeratedSequence<[Double]>.Element) -> Bool in
                v.element.distance(to: 0.0667) < 0.001
            })?
            .offset ?? 0)
            .map { (i: Int) -> Int in
                i + 1
            }
    }
}

// MARK: - Split String

/**
 retorna um conjunto de substrings pulando os caracteres de acordo com o step
 ex. "banana".substring(step: 2) == ["bnn", "aaa"]
 
 - parameter step: indica quantas casas ira pular até pegar o próximo caracter
 */
func substrings(step: Int, selfArray: [Character]) -> [[Character]] {
    stride(from: .zero, to: step, by: 1)
        .map { (i: Int) -> [Character] in
            substring(start: i, step: step, selfArray: selfArray)
    }
}

/**
 retorna uma substring pulando os caracteres de acordo com o step
 ex. "banana".substring(start 1, step: 2) == "aaa"
 
 - parameter start: indica onde a substring irá começar
 - parameter step: indica quantas casas ira pular até pegar o próximo caracter
 */
func substring(start: Int = .zero, step: Int = 1, selfArray: [Character]) -> [Character] {
    stride(from: start, to: selfArray.count, by: max(step, 1))
        .map { (i: Int) -> Character in
            selfArray[i]
    }
}

extension String {
    
    var array: [Character] {
        Array(self)
    }
    
    var crypt: Crypt {
        .init(self)
    }
}

// MARK: - Counters

/// conta a frequencia de cada caracter da string
/// retorna um dicionario com os caracteres e suas quantidades
func frequencies(selfArray: [Character]) -> [Character: Int] {
    selfArray.reduce(into: [Character: Int]()) { dict, value in
        dict[value] = (dict[value] ?? 0) + 1
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
