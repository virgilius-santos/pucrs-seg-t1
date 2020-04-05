
import XCTest
@testable import SecurityDecrypt

class DictionaryExtTests: XCTestCase {
    func test_frequency_total() {
        let crypt: Crypt = Crypt("addfffgggg")
        let frequency: [Character: Int] = crypt.frequencies().first!
        XCTAssertEqual(frequency.total, crypt.selfArray.count)
    }
    
    func test_frequency_letterMostFreq() {
        let crypt: Crypt = Crypt("addfffgggg")
        let frequency: [Character: Int] = crypt.frequencies().first!
        let letterMostFreq = frequency.letterMostFreq(qtd: 2)
        XCTAssertEqual(letterMostFreq.count, 2)
        XCTAssertEqual(letterMostFreq[0].letter, "g")
        XCTAssertEqual(letterMostFreq[0].qtd, 4)
        XCTAssertEqual(letterMostFreq[1].letter, "f")
        XCTAssertEqual(letterMostFreq[1].qtd, 3)
    }
}
