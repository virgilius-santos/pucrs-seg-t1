
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
        let letterMostFreq = frequency.letterMostFreq()
        XCTAssertEqual(letterMostFreq, "g")
    }
}
