
import Foundation

extension Dictionary where Key == String, Value == Int {
    var total: Int {
        values.reduce(0, +)
    }
    
    func letterMostFreq(qtd: Int) -> [(letter: String, qtd: Int)] {
        self.sorted(by: { $0.value > $1.value })
            .prefix(qtd)
            .map { ($0.key, $0.value) }
    }
}
