
import Foundation

public class Crypt {
    
    /// alfabeto usado no programa
    static let alphabet: [Character] = {
        Array("abcdefghijklmnopqrstuvwxyz")
    }()
    
    /// matriz de vigenere
    static let matrizVigenere: [Character: [Character: Character]] = {
        alphabet
            .enumerated()
            .reduce(into: [Character: [Character: Character]](), { (m, kv1) in
                let (i,ck) = kv1
                if m[ck] == nil { m[ck] = [:] }
                alphabet
                    .enumerated()
                    .forEach { (j, ca) in
                        m[ck]![ca] = alphabet[(j+i)%26]
                }
        })
    }()
    
    /// matriz de vigenere invertida, usando os valores como chaves
    static let matrizVigenereInverted: [Character: [Character: Character]] = {
        alphabet
            .enumerated()
            .reduce(into: [Character: [Character: Character]](), { (m, kv1) in
                let (i,ck) = kv1
                if m[ck] == nil { m[ck] = [:] }
                alphabet
                    .enumerated()
                    .forEach { (j, ca) in
                        m[ck]![alphabet[(j+i)%26]] = ca
                }
            })
    }()
}

