
import Foundation

public class Main {
    public static func decrypt(crypt: String) -> String {
        crypt
            .map { (w: String) -> [String] in
                let step: Int = w.findStepOfIndexOfCoincidence()
                return w.substrings(step: step)
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
                Crypt.char(key: "e", fromAlphabet: c)
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
