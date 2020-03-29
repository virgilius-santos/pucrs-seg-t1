
import Foundation

public class Crypt {
    
    /// alfabeto usado no programa
    static let alphabet: [Character] = {
        Array("abcdefghijklmnopqrstuvwxyz")
    }()
    
    /// matriz de vigenere usada no programa
    static let matrizVigenere: [Character: [Character]] = {
        alphabet
            .enumerated()
            .reduce(into: [Character: [Character]](), {
                $0[$1.element] = alphabet.suffix(alphabet.count - $1.offset)
                    + alphabet.prefix($1.offset)
            }
        )
    }()
    
    /// retorna o index do alfabedo do caracter informado
    static func index(char: Character) -> Int? {
        alphabet.firstIndex(where: { $0 == char })
    }
    
    /// para uma determinada key, busca o index de um caracter char na matriz
    static func index(key: Character, char: Character) -> Int? {
        matrizVigenere[key]?.firstIndex(where: { $0 == char })
    }
    
    /// busca o index do char informado no alfabeto,
    /// e na lista de valores relacionados a key
    /// retorna o char dos valores relacionados key que esta na posicao do index
    static func char(key: Character, fromValue char: Character) -> Character? {
        guard
            let index = index(char: char),
            let values = matrizVigenere[key],
            index < values.count
            else { return nil }
        
        return values[index]
    }
    
    /// pega a lista de valores de uma key
    /// procura o index do char passado
    /// retorna o char do alfabedo que esta na posicao do index
    static func char(key: Character, fromAlphabet char: Character) -> Character? {
        guard
            let index = index(key: key, char: char),
            index < alphabet.count
        else { return nil }
        
        return alphabet[index]
    }
}

