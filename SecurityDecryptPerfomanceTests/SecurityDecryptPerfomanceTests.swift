
import XCTest
@testable import SecurityDecrypt

class PerfomanceTests: XCTestCase {
    
    let textEncrypted: String = Read.read("String2", format: "txt")!.alphanumeric.lowercased()
    let decrypt: String = Read.read("String3", format: "txt")!.alphanumeric.lowercased()
    
    func testPerformanceTotal() throws {
        self.measure {
            XCTAssertEqual(Main.decrypt(crypt: textEncrypted), decrypt)
        }
    }
    
    func testPerformanceDecrypt() throws {
        self.measure {
            XCTAssertEqual(textEncrypted.decrypt(key: "meunome"), decrypt)
        }
    }
    
    func testPerformanceKeySize() throws {
        self.measure {
            XCTAssertEqual(textEncrypted.findFirstClosestndexOfCoincidence(), 7)
        }
    }
}
