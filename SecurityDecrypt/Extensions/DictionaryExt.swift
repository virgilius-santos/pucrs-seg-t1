
import Foundation

extension Dictionary where Key == Character, Value == Int {
    /// calcula o somatorio dos valores presentes no dicionario
    var total: Int {
        values.reduce(0, +)
    }

    /// retorna um array com os caracteres mais frequentes em ordem decrescente
    /// qtd: número de itens retornados
    func letterMostFreq() -> Character {
        self.max(by: { $0.value < $1.value }).map { ($0.key, $0.value) }!.0
    }
}
