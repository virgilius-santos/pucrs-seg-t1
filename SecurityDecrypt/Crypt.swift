
import Foundation

public final class Crypt {
    let word: String
    let selfArray: [Character]
    var newArray: [Character]
    
    init(_ w: String) {
        word = w
        selfArray = Array(w.alphanumeric.lowercased())
        newArray = selfArray
    }
    
    func decrypt() -> String {
        findKey()
            .map { (k: [Character]) -> String in
                decrypt(key: k)
            }
    }
    
    func findKey() -> [Character] {
        findFirstClosestIndexOfCoincidence()
            .map { (index: Int) -> [[Character]] in
                selfArray.substrings(step: index)
            }
            .map { (substrings: [Character]) -> [Character: Int] in
                substrings.frequencies()
            }
            .flatMap { (freq: [Character: Int]) -> [(letter: Character, qtd: Int)] in
                freq.letterMostFreq(qtd: 1)
            }
            .compactMap { (letter: Character, _: Int) -> Character? in
                Crypt.matrizVigenereInverted["e"]?[letter]
            }
    }
    
    /// gera dez indiecs de coincidencia e retorna o primeiro indice do mais proximo ao valor default 0.0667
    func findFirstClosestIndexOfCoincidence() -> Int {
        (generateIndexOfCoincidence(qtd: 10)
            .enumerated()
            .first(where: { (v: EnumeratedSequence<[Double]>.Element) -> Bool in
                v.element.distance(to: 0.0667) < 0.001
            })?
            .offset ?? 0)
            .map { (i: Int) -> Int in
                i + 1
            }
    }
    
    /// de acordo com a qtd informada gera uma serie de indices de coincidencia variando o step
    func generateIndexOfCoincidence(qtd: Int) -> [Double] {
        stride(from: 1, to: qtd + 1, by: 1)
            .map { (i: Int) -> Double in
                indexOfCoincidence(step: i)
            }
    }
    
    // MARK: Index of coincidence
    
    /// quebra a string em substrings usando o step
    /// depois cacula o indice de coincidencia de cada substrings
    func indexOfCoincidence(step: Int = 1) -> Double {
        selfArray.substrings(step: step)
            .reduce(Double.zero) { (old: Double, word: [Character]) -> Double in
                old + indexOfCoincidence(freqs: word.frequencies())
            }
            .map { (v: Double) -> Double in
                v / Double(step)
            }
    }
    
    /// calcula o indice de coincidencia da String usando a frequencia dos caracteres
    func indexOfCoincidence(freqs: [Character: Int]) -> Double {
        let total: Int = freqs.total
        let const: Double = Double(total * (total - 1))
        let values: [Double] = freqs.values.map { Double($0) }
        
        guard const > .zero else { return .zero }
        
        let sum: Double = values
            .reduce(.zero) { (old: Double, new: Double) -> Double in
                old + (new * (new - 1))
            }
        return sum / const
    }
}

// MARK: - Vigenere

extension Crypt {
    // MARK: Decrypt
    
    /// faz a decriptacao usando a chave que foi passada
    func decrypt(key: [Character]) -> String {
        stride(from: 0, to: key.count, by: 1)
            .reduce(into: newArray) { (array: inout [Character], keyIndex: Int) in
                stride(from: keyIndex, to: selfArray.count, by: max(key.count, 1))
                    .forEach { [m = Crypt.matrizVigenereInverted] (charIndex: Int) in
                        array[charIndex] = m[key[keyIndex]]![selfArray[charIndex]]!
                    }
            }
            .map { (array: [Character]) -> String in
                array.string
            }
    }
    
    // MARK: Encrypt
    
    /// faz a encriptacao usando a chave que foi passada
    func encrypt(key: [Character]) -> String {
        stride(from: 0, to: key.count, by: 1)
            .reduce(into: newArray) { (array: inout [Character], keyIndex: Int) in
                stride(from: keyIndex, to: selfArray.count, by: max(key.count, 1))
                    .forEach { [m = Crypt.matrizVigenere] (charIndex: Int) in
                        array[charIndex] = m[key[keyIndex]]![selfArray[charIndex]]!
                    }
            }
            .map { (array: [Character]) -> String in
                array.string
            }
    }
}

// MARK: - Statics

extension Crypt {
    /// alfabeto usado no programa
    static let alphabet: [Character] = {
        Array("abcdefghijklmnopqrstuvwxyz")
    }()
    
    /// gera dicionário com as letras associadas a 0
    static var alphabetDict: [Character: Int] {
        Array("abcdefghijklmnopqrstuvwxyz")
            .reduce(into: [Character: Int]()) { $0[$1] = 0 }
    }
    
    /// matriz de vigenere
    static let matrizVigenere: [Character: [Character: Character]] = {
        alphabet
            .enumerated()
            .reduce(into: [Character: [Character: Character]]()) { m, kv1 in
                let (i, ck) = kv1
                if m[ck] == nil { m[ck] = [:] }
                alphabet
                    .enumerated()
                    .forEach { j, ca in
                        m[ck]![ca] = alphabet[(j + i) % 26]
                    }
            }
    }()
    
    /// matriz de vigenere invertida, usando os valores como chaves
    static let matrizVigenereInverted: [Character: [Character: Character]] = {
        alphabet
            .enumerated()
            .reduce(into: [Character: [Character: Character]]()) { m, kv1 in
                let (i, ck) = kv1
                if m[ck] == nil { m[ck] = [:] }
                alphabet
                    .enumerated()
                    .forEach { j, ca in
                        m[ck]![alphabet[(j + i) % 26]] = ca
                    }
            }
    }()
}
