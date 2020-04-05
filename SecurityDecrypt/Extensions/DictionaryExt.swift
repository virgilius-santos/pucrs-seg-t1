
import Foundation

extension Dictionary where Key == Character, Value == Int {
    
    /// calcula o somatorio dos valores presentes no dicionario
    var total: Int {
        values.reduce(0, +)
    }
    
    /// retorna um array com os caracteres mais frequentes em ordem decrescente
    /// qtd: número de itens retornados
    func letterMostFreq(qtd: Int) -> [(letter: Character, qtd: Int)] {
        self.sorted(by: { $0.value > $1.value })
            .prefix(qtd)
            .map { ($0.key, $0.value) }
    }
}
