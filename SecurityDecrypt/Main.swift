
import Foundation

class Main {
    
    static func decrypt(crypt: String) -> String {
        let step: Int
        let substrings: [String]
        let frequencies: [(word: String, freq: [String: Int])]
        let mostFreq: [(word: String, freq: [(letter: String, qtd: Int)])]
        var word: String
        var key: String
        
        step = crypt.findStepOfIndexOfCoincidence()
        print("tamanho da chave: ", step)
        substrings = crypt.substrings(step: step)
        frequencies = substrings.map { ($0, $0.frequencies() )}
        mostFreq = frequencies.map { ($0.word, $0.freq.letterMostFreq(qtd: 3) )}
        
        for i in 0 ..< step {
            print("")
            mostFreq[i].freq.forEach { print($0) }
            print("")
        }
        
        //        key = "azipmro"
        //        key = "avipmro"
        //        key = "avepmro"
        //        key = "avelmro"
        //        key = "aveliro"
        key = "avelino"
        word = crypt.decrypt(key: key)
        
        let srs = stride(from: 0, to: word.count, by: step)
            .map { i in word[i..<i+step] + "\t" }
            .reduce("", +)
        print(srs)
        
        return word
    }
}
