
import Foundation

public final class Crypt {
    let selfArray: [Character]
    var keyArray: [Character]
    var newArray: [Character]
    
    init(_ w: String, key: String = "") {
        keyArray = key.alphanumeric.lowercased().array
        selfArray = w.alphanumeric.lowercased().array
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
            .map { (index: Int) -> [[Character: Int]] in
                selfArray.frequencies(step: index)
            }
            .map { (freq: [Character: Int]) -> Character in
                Crypt.matrizVigenereInverted["e"]![freq.letterMostFreq()]!
            }
    }
    
    // MARK: Index of coincidence
    
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
        stride(from: 0, to: qtd, by: 1)
            .map { (i: Int) -> Double in
                indexOfCoincidence(step: i + 1)
        }
    }
    
    /// quebra a string em substrings usando o step
    /// depois cacula o indice de coincidencia de cada substrings
    func indexOfCoincidence(step: Int = 1) -> Double {
        selfArray.frequencies(step: step)
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
    func decrypt(key keyArray: [Character]) -> String {
        stride(from: 0, to: keyArray.count, by: 1)
            .reduce(into: newArray) { (array: inout [Character], keyIndex: Int) in
                stride(from: keyIndex, to: selfArray.count, by: max(keyArray.count, 1))
                    .forEach { [m = Crypt.matrizVigenereInverted] (charIndex: Int) in
                        array[charIndex] = m[keyArray[keyIndex]]![selfArray[charIndex]]!
                    }
            }
            .map { (array: [Character]) -> String in
                array.string
            }
    }
    
    // MARK: Encrypt
    
    /// faz a encriptacao usando a chave que foi passada
    func encrypt() -> String {
        stride(from: 0, to: keyArray.count, by: 1)
            .reduce(into: newArray) { (array: inout [Character], keyIndex: Int) in
                stride(from: keyIndex, to: selfArray.count, by: max(keyArray.count, 1))
                    .forEach { [m = Crypt.matrizVigenere] (charIndex: Int) in
                        array[charIndex] = m[keyArray[keyIndex]]![selfArray[charIndex]]!
                    }
            }
            .map { (array: [Character]) -> String in
                array.string
            }
    }
    
    func encrypt(key: [Character]) -> String {
        keyArray = key
        return encrypt()
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
