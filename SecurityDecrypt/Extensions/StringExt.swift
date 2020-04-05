
import Foundation

// MARK: - Vigenere Encrypt

extension String {
    /// faz a encriptacao usando a chave que foi passada
    func encrypt(key: String) -> String {
        let selfArray: [Character] = Array(self)
        let keyArray: [Character] = Array(key)
        return stride(from: 0, to: count, by: key.count)
            .flatMap { (i: Int) -> [Character] in
                encrypt(key: keyArray,
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
}

// MARK: - Vigenere Decrypt

extension String {
//    /// faz a decriptacao usando a chave que foi passada
//    func decrypt(key: [Character]) -> String {
//        print("------", key, "------")
//        let selfArray: [Character] = Array(self)
//        let keyArray: [Character] = key
//        return stride(from: 0, to: count, by: key.count)
//            .flatMap { (i: Int) -> [Character] in
//                decrypt(key: keyArray,
//                        slice: selfArray[i ..< min(i + key.count, selfArray.count)],
//                        i)
//        }
//        .map { (c: Character) -> String in
//            String(c)
//        }
//        .reduce("", +)
//    }

    /// faz a decriptacao usando a chave que foi passada
    /// pegando as letras da String a partir da variavel i informada
    func decrypt(key: [Character], slice: ArraySlice<Character>, _ j: Int) -> [Character] {
        slice
            .enumerated()
            .compactMap { (i: Int, c: Character) -> Character? in
                Crypt.matrizVigenereInverted[key[i]]?[c]
            }
    }
}

extension String {
    
    var array: [Character] {
        Array(self)
    }
    
    var crypt: Crypt {
        .init(self)
    }
}

// MARK: - Formatters

public extension String {
    /// retorna apenas os caracteres alphanumericos
    var alphanumeric: String {
        self.components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined()
    }
}
