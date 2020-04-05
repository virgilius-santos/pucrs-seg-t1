
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
        findFirstClosestndexOfCoincidence()
            .map { (index: Int) -> [[Character]] in
                substrings(step: index, selfArray: word.array)
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
        .map { (k: [Character]) -> String in
            decrypt(key: k)
        }
//        findFirstClosestndexOfCoincidence()
//            .map { (index: Int) -> [[Character: Int]] in
//                frequencies(step: index)
//            }
//            .flatMap { (freq: [Character: Int]) -> [(letter: Character, qtd: Int)] in
//                freq.letterMostFreq(qtd: 1)
//            }
//            .compactMap { (letter: Character, _: Int) -> Character? in
//                Crypt.matrizVigenereInverted["e"]?[letter]
//            }
//            .map { (k: [Character]) -> String in
//                decrypt(key: k)
//            }
    }
    
    // MARK: - Vigenere Decrypt
    
    /// faz a decriptacao usando a chave que foi passada
    func decrypt(key: [Character]) -> String {
        stride(from: 0, to: key.count, by: 1)
            .reduce(into: newArray, { (array: inout [Character], keyIndex: Int) in
                stride(from: keyIndex, to: selfArray.count, by: max(key.count, 1))
                    .forEach { [m = Crypt.matrizVigenereInverted] (charIndex: Int) in
                        array[charIndex] = m[key[keyIndex]]![selfArray[charIndex]]!
                }
            })
            .map { (array: [Character]) -> String in
                array.string
        }
    }
    
    // MARK: - Vigenere Encrypt
    
    /// faz a encriptacao usando a chave que foi passada
    func encrypt(key: [Character]) -> String {
        stride(from: 0, to: selfArray.count, by: key.count)
            .flatMap { (i: Int) -> [Character] in
                encrypt(key: key,
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
    
    // MARK: Index of coincidence
    
    /// quebra a string em substrings usando o step
    /// depois cacula o indice de coincidencia de cada substrings
    func indexOfCoincidence(step: Int = 1) -> Double {
        substrings(step: step, selfArray: selfArray)
            .reduce(Double.zero) { (old: Double, word: [Character]) -> Double in
                old + indexOfCoincidence(freqs: word.frequencies())
        }
        .map { (v: Double) -> Double in
            v / Double(step)
        }
//        selfArray.frequencies(step: step)
//            .reduce(Double.zero) { (old: Double, freqs: [Character: Int]) -> Double in
//                old + indexOfCoincidence(freqs: freqs)
//            }
//            .map { (v: Double) -> Double in
//                v / Double(step)
//            }
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
    
    // MARK: Counters
    
    /// de acordo com a qtd informada gera uma serie de indices de coincidencia variando o step
    func generateIndexOfCoincidence(qtd: Int) -> [Double] {
        stride(from: 1, to: qtd + 1, by: 1)
            .map { (i: Int) -> Double in
                indexOfCoincidence(step: i)
            }
    }
    
    /// gera dez indiecs de coincidencia e retorna o primeiro indice do mais proximo ao valor default 0.0667
    func findFirstClosestndexOfCoincidence() -> Int {
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
