
import XCTest
@testable import SecurityDecrypt

class DictionaryExtTests: XCTestCase {
    func test_frequency_total() {
        let array = "addfffgggg".array
        let frequency: [Character: Int] = array.frequencies()
        XCTAssertEqual(frequency.total, array.count)
    }
    
    func test_frequency_letterMostFreq() {
        let array = "addfffgggg".array
        let frequency: [Character: Int] = array.frequencies()
        let letterMostFreq = frequency.letterMostFreq(qtd: 2)
        XCTAssertEqual(letterMostFreq.count, 2)
        XCTAssertEqual(letterMostFreq[0].letter, "g")
        XCTAssertEqual(letterMostFreq[0].qtd, 4)
        XCTAssertEqual(letterMostFreq[1].letter, "f")
        XCTAssertEqual(letterMostFreq[1].qtd, 3)
    }
}
