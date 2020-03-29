
import Foundation

// MARK: Index of coincidence

extension String {
    
    func decrypt() {
        
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
