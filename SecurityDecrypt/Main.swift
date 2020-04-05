
import Foundation

public class Main {
    public static func decrypt(crypt: String) -> String {
        crypt
            .map { (word: String) -> [String] in
                word
                    .findFirstClosestndexOfCoincidence()
                    .map { (index: Int) -> [String] in
                        word.substrings(step: index)
                    }
            }
            .map { (substring: String) -> [String: Int] in
                substring.frequencies()
            }
            .flatMap { (freq: [String: Int]) -> [(letter: String, qtd: Int)] in
                freq.letterMostFreq(qtd: 1)
            }
            .map { (letter: String, _: Int) -> Character in
                Character(letter)
            }
            .compactMap { (c: Character) -> Character? in
                Crypt.matrizVigenereInverted["e"]?[c]
            }
            .map { (c: Character) -> String in
                String(c)
            }
            .reduce("", +)
            .map { (k: String) -> String in
                crypt.decrypt(key: k)
            }
    }
}
