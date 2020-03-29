
import Foundation

extension String {
    var alphanumeric: String {
        self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    }
    
    func substrings(step: Int) -> [String] {
        var substrings = [String]()
        for i in 0 ..< step {
            substrings.append(substring(start: i, step: step))
        }
        return substrings
    }
    
    func substring(start: Int = 0, step: Int = 1) -> String {
        guard step > 1, start >= 0 else { return self }
        let array: [Character] = Array(self)
        var newString = String()
        stride(from: start, to: array.count, by: step).forEach { i in
            newString += String(array[i])
        }
        return newString
    }
    
    func frequencies() -> [String: Int] {
        reduce(into: [String: Int]()) { (dict, value) in
            let str = String(value)
            dict[str] = (dict[str] ?? 0) + 1
        }
    }
    
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
    
    func findIndexOfCoincidence() -> Double {
        return generateIndexOfCoincidence(qtd: 10).max() ?? 0
    }
    
    func generateIndexOfCoincidence(qtd: Int) -> [Double] {
        stride(from: 1, to: qtd + 1, by: 1)
            .map { indexOfCoincidence(step: $0) }
    }
}
