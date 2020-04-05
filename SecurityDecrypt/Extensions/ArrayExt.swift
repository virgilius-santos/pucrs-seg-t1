
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
    
    /// conta a frequencia de cada caracter do Array
    /// retorna um dicionario com os caracteres e suas quantidades
//    func frequencies(step: Int = 1) -> [[Character: Int]] {
//        stride(from: 0, to: step, by: 1)
//            .reduce(into: [[Character: Int]](), { (array: inout [[Character: Int]], start: Int) in
//                array.append(
//                    stride(from: start, to: count, by: Swift.max(step, 1))
//                        .reduce(into: Crypt.alphabetDict, { (dict: inout [Character: Int], i: Int) in
//                            dict[self[i]]! += 1
//                        })
//                )
//            })
//    }
}
