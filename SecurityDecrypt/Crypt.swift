
import Foundation

public class Crypt {
    static var alphabet: [Character] {
        Array("abcdefghijklmnopqrstuvwxyz")
    }
    
    static var matrizVigenere: [Character: [Character]] = {
        alphabet.enumerated()
            .reduce(into: [Character: [Character]](), {
                $0[$1.element] = alphabet.suffix(alphabet.count - $1.offset)
                    + alphabet.prefix($1.offset)
            }
        )
    }()
    
    static func index(char: Character) -> Int {
        alphabet.firstIndex(where: { $0 == char }) ?? 0
    }
    
    static func index(key: Character, char: Character) -> Int {
        matrizVigenere[key]?.firstIndex(where: { $0 == char }) ?? 0
    }
    
    static func char(key: Character, fromAlphabet char: Character) -> Character {
        alphabet[index(key: key, char: char)]
    }
    
    static func char(key: Character, fromValue char: Character) -> Character {
        Crypt.matrizVigenere[key]?[index(char: char)] ?? "-"
    }
}

