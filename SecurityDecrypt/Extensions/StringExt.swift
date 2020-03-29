
import Foundation

// MARK: Decrypt

extension String {
    
    func decrypt() -> String {
        let step: Int
        let substrings: [String]
        let frequencies: [(word: String, freq: [String: Int])]
        let mostFreq: [(word: String, freq: [(letter: String, qtd: Int)])]
        
        step = findStepOfIndexOfCoincidence()
        substrings = self.substrings(step: step)
        frequencies = substrings.map { ($0, $0.frequencies() )}
        mostFreq = frequencies.map { ($0.word, $0.freq.letterMostFreq(qtd: 4) )}
        return mostFreq[0].word
    }
}

// MARK: Vigenere Encrypt

extension String {
    
    func encrypt(key: String) -> String {
        guard !key.isEmpty, !self.isEmpty else { return self }
        return stride(from: 0, to: count, by: key.count)
            .map({ i -> String in encrypt(i: i, key: key) })
            .reduce("", { (old: String, new: String) -> String in old + new })
    }
    
    func encrypt(i: Int, key: String) -> String {
        stride(from: 0, to: key.count, by: 1)
            .map { j -> Character in Crypt.char(key: Array(key.lowercased())[j],
                                                fromValue: Array(self)[i + j]) }
            .map { c -> String in String(c) }
            .reduce("", +)
    }
}

// MARK: Vigenere Decrypt

extension String {
    
    func decrypt(key: String) -> String {
        guard !key.isEmpty, !self.isEmpty else { return self }
        return stride(from: 0, to: count, by: key.count)
            .map { i -> String in decrypt(i: i, key: key) }
            .reduce("", { (old: String, new: String) -> String in old + new })
    }
    
    func decrypt(i: Int, key: String) -> String {
        stride(from: 0, to: key.count, by: 1)
            .map { j -> Character in Crypt.char(key: Array(key.lowercased())[j],
                                                fromAlphabet: Array(self)[i + j]) }
            .map { c -> String in String(c) }
            .reduce("", +)
    }
}

// MARK: Index of coincidence

extension String {
    
    func indexOfCoincidence(step: Int) -> Double {
        return self.substrings(step: step)
            .reduce(Double.zero) { $0 + $1.indexOfCoincidence() }
            .map { $0 / Double(step) }
    }
    
    func indexOfCoincidence() -> Double {
        let frequencies: [String : Int] = self.frequencies()
        let total: Int = frequencies.total
        let const: Int = total * (total - 1)
        let values: [Int] = frequencies.values.map { $0 }
        
        guard const > .zero else { return .zero }
        
        let sum: Int = values.reduce(0, { $0 + ($1 * ($1 - 1)) })
        return Double(sum) / Double(const)
    }
    
    func findStepOfIndexOfCoincidence() -> Int {
        return (generateIndexOfCoincidence(qtd: 10)
            .enumerated()
            .max(by: { $0.element < $1.element })?
            .offset ?? 0) + 1
    }
    
    func generateIndexOfCoincidence(qtd: Int) -> [Double] {
        stride(from: 1, to: qtd + 1, by: 1)
            .map { indexOfCoincidence(step: $0) }
    }
}

// MARK: Split String

extension String {
    func substrings(step: Int) -> [String] {
        var substrings = [String]()
        for i in 0 ..< step {
            substrings.append(substring(start: i, step: step))
        }
        return substrings
    }
    
    func substring(start: Int = 0, step: Int = 1) -> String {
        guard start >= 0, step > 1  else { return self }
        let array: [Character] = Array(self)
        var newString = String()
        stride(from: start, to: array.count, by: step).forEach { i in
            newString += String(array[i])
        }
        return newString
    }
}

// MARK: Counters

extension String {
    func frequencies() -> [String: Int] {
        reduce(into: [String: Int]()) { (dict, value) in
            let str = String(value)
            dict[str] = (dict[str] ?? 0) + 1
        }
    }
}

// MARK: Formatters

extension String {
    var alphanumeric: String {
        self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    }
}
