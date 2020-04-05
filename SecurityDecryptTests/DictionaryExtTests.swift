
import XCTest
@testable import SecurityDecrypt

class DictionaryExtTests: XCTestCase {
    func test_frequency_total() {
        let word: String = "addfffgggg"
        let frequency: [Character: Int] = frequencies(selfArray: word.array)
        XCTAssertEqual(frequency.total, word.count)
    }
    
    func test_frequency_letterMostFreq() {
        let word: String = "addfffgggg"
        let frequency: [Character: Int] = frequencies(selfArray: word.array)
        let letterMostFreq = frequency.letterMostFreq(qtd: 2)
        XCTAssertEqual(letterMostFreq.count, 2)
        XCTAssertEqual(letterMostFreq[0].letter, "g")
        XCTAssertEqual(letterMostFreq[0].qtd, 4)
        XCTAssertEqual(letterMostFreq[1].letter, "f")
        XCTAssertEqual(letterMostFreq[1].qtd, 3)
    }
}
