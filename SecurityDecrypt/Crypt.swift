
import Foundation

public final class Crypt {
    enum Language: Double {
        case portuguese = 0.072723
        case english = 0.0667
        
        var character: Character {
            switch self {
            case .portuguese:
                return "e"
            case .english:
                return "e"
            }
        }
    }
    
    let word: String
    let selfArray: [Character]
    var newArray: [Character]
    let language: Language
    var dicts: [[[Character: Int]]] = []
    
    init(_ w: String, language lg: Language = .english) {
        word = w
        selfArray = Array(w.alphanumeric.lowercased())
        newArray = selfArray
        language = lg
    }
    
    func decrypt() -> String {
        findKey()
            .map { (k: [Character]) -> String in
                decrypt(key: k)
            }
    }
    
    func findKey() -> [Character] {
        findFirstClosestIndexOfCoincidence()
            .map { (index: Int) -> [[Character: Int]] in
                self.dicts[index]
            }
            .map { (freq: [Character: Int]) -> Character in
                freq.letterMostFreq()
            }
            .map { [language] (letter: Character) -> Character in
                Crypt.matrizVigenereInverted[language.character]![letter]!
            }
    }
    
    /// gera dez indiecs de coincidencia e retorna o primeiro indice do mais proximo ao valor default 0.0667
    func findFirstClosestIndexOfCoincidence() -> Int {
        (generateIndexOfCoincidence(qtd: 10)
            .enumerated()
            .first(where: { [language] (v: EnumeratedSequence<[Double]>.Element) -> Bool in
                v.element.distance(to: language.rawValue) < 0.01
            })?
            .offset ?? 0)
    }
    
    /// de acordo com a qtd informada gera uma serie de indices de coincidencia variando o step
    func generateIndexOfCoincidence(qtd: Int) -> [Double] {
        stride(from: 0, to: qtd, by: 1)
            .map { (step: Int) -> Double in
                indexOfCoincidence(step: step + 1)
            }
    }
    
    // MARK: Index of coincidence
    
    /// quebra a string em substrings usando o step
    /// depois cacula o indice de coincidencia de cada substrings
    func indexOfCoincidence(step: Int = 1) -> Double {
        selfArray.frequencies(step: step)
            .do { dicts in
                self.dicts.append(dicts)
            }
            .reduce(Double.zero) { (old: Double, freqs: [Character: Int]) -> Double in
                old + indexOfCoincidence(freqs: freqs)
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
