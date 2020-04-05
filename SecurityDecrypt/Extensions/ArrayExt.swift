
import Foundation

extension Array where Element == Character {
    var string: String {
        String(self)
    }
    
    func map<T>(completion: ([Character]) -> T) -> T {
        completion(self)
    }
    
    // MARK: - Counters
    
    /// conta a frequencia de cada caracter da string
    /// retorna um dicionario com os caracteres e suas quantidades
    func frequencies() -> [Character: Int] {
        reduce(into: [Character: Int]()) { dict, value in
            dict[value] = (dict[value] ?? 0) + 1
        }
    }
    
    // MARK: - Split Array
    
    /**
     retorna um conjunto de substrings pulando os caracteres de acordo com o step
     ex. "banana".substring(step: 2) == ["bnn", "aaa"]
     
     - parameter step: indica quantas casas ira pular até pegar o próximo caracter
     */
    func substrings(step: Int) -> [[Character]] {
        stride(from: .zero, to: step, by: 1)
            .map { (i: Int) -> [Character] in
                substring(start: i, step: step)
            }
    }
    
    /**
     retorna uma substring pulando os caracteres de acordo com o step
     ex. "banana".substring(start 1, step: 2) == "aaa"
     
     - parameter start: indica onde a substring irá começar
     - parameter step: indica quantas casas ira pular até pegar o próximo caracter
     */
    func substring(start: Int = .zero, step: Int = 1) -> [Character] {
        stride(from: start, to: count, by: Swift.max(step, 1))
            .map { (i: Int) -> Character in self[i] }
    }
    
    func frequencies(step: Int) -> [[Character: Int]] {
        stride(from: .zero, to: step, by: 1)
            .map { (start: Int) -> [Character: Int] in
                stride(from: start, to: count, by: Swift.max(step, 1))
                    .reduce(into: [Character: Int]()) { dict, value in
                        dict[self[value]] = (dict[self[value]] ?? 0) + 1
                    }
            }
    }
}
