
import XCTest
@testable import SecurityDecrypt

class DictionaryExtTests: XCTestCase {
    func test_frequency_total() {
        let array = "addfffgggg".array
        let frequency: [Character: Int] = array.frequencies().first!
        XCTAssertEqual(frequency.total, array.count)
    }
    
    func test_frequency_letterMostFreq() {
        let array = "addfffgggg".array
        let frequency: [Character: Int] = array.frequencies().first!
        let letterMostFreq = frequency.letterMostFreq()
        XCTAssertEqual(letterMostFreq, "g")
    }
}
