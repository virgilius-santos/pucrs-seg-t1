
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
            .map { (substring: String) -> [Character: Int] in
                frequencies(selfArray: substring.array)
            }
            .flatMap { (freq: [Character: Int]) -> [(letter: Character, qtd: Int)] in
                freq.letterMostFreq(qtd: 1)
            }
            .compactMap { (letter: Character, _: Int) -> Character? in
                Crypt.matrizVigenereInverted["e"]?[letter]
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
