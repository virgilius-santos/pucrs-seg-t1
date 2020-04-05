
import Foundation

public class Main {
    public static func decrypt(crypt: String) -> String {
        crypt
            .map { (word: String) -> [[Character]] in
                word
                    .findFirstClosestndexOfCoincidence()
                    .map { (index: Int) -> [[Character]] in
                        substrings(step: index, selfArray: word.array)
                    }
            }
            .map { (substrings: [Character]) -> [Character: Int] in
                frequencies(selfArray: substrings)
            }
            .flatMap { (freq: [Character: Int]) -> [(letter: Character, qtd: Int)] in
                freq.letterMostFreq(qtd: 1)
            }
            .compactMap { (letter: Character, _: Int) -> Character? in
                Crypt.matrizVigenereInverted["e"]?[letter]
            }
            .map { (k: [Character]) -> String in
                crypt.decrypt(key: k)
            }
    }
}
