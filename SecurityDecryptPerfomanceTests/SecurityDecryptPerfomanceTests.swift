
import XCTest
@testable import SecurityDecrypt

class PerfomanceTests: XCTestCase {
    
    let textEncrypted: String = Read.read("String2")!.alphanumeric.lowercased()
    let decrypt: String = Read.read("String3")!.alphanumeric.lowercased()
    
    func testPerformanceTotal() throws {
        self.measure {
            XCTAssertEqual(Main.decrypt(crypt: textEncrypted), decrypt)
        }
    }
    
    func testPerformanceTotalEngrypt() throws {
        self.measure {
            XCTAssertEqual(Main.encrypt(crypt: decrypt, key: "meunome"), textEncrypted)
        }
    }
    
    func testPerformanceDecrypt() throws {
        self.measure {
            XCTAssertEqual(textEncrypted.crypt.decrypt(key: "meunome".array), decrypt)
        }
    }
    
    func testPerformanceKeySize() throws {
        self.measure {
            XCTAssertEqual(textEncrypted.crypt.findFirstClosestIndexOfCoincidence(), 7)
        }
    }
    
    func testPerformanceFindKey() throws {
        self.measure {
            XCTAssertEqual(textEncrypted.crypt.findKey(), "meunome".array)
        }
    }
}
