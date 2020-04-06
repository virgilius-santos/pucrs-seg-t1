
import XCTest
@testable import SecurityDecrypt

class PerfomanceTests: XCTestCase {
    
    let textEncrypted: String = Read.read("String2")!.alphanumeric.lowercased()
    let textEncrypted2: String = Read.read("String4")!.alphanumeric.lowercased()
    let decrypt: String = Read.read("String3")!.alphanumeric.lowercased()
    let decrypt2: String = Read.read("String5")!.alphanumeric.lowercased()
    
    func testPerformanceTotal() throws {
        let crypt = Crypt(textEncrypted)
        self.measure {
            XCTAssertEqual(crypt.decrypt(), decrypt)
        }
    }
    
    func testPerformanceTotalEngrypt() throws {
        let crypt = Crypt(decrypt, key: "meunome")
        self.measure {
            XCTAssertEqual(crypt.encrypt(), textEncrypted)
        }
    }
    
    func testPerformanceDecrypt() throws {
        let crypt = Crypt(textEncrypted)
        let key = "meunome".array
        self.measure {
            XCTAssertEqual(crypt.decrypt(key: key), decrypt)
        }
    }
    
    func testPerformanceKeySize() throws {
        let crypt = Crypt(textEncrypted)
        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false)  {
            startMeasuring()
            _ = crypt.findFirstClosestIndexOfCoincidence()
            stopMeasuring()
        }
    }
    
    func testPerformanceFindKey() throws {
        let crypt = Crypt(textEncrypted)
        self.measureMetrics([XCTPerformanceMetric.wallClockTime], automaticallyStartMeasuring: false)  {
            startMeasuring()
            _ = crypt.findKey()
            stopMeasuring()
        }
    }
    
    func testPerformanceLong() throws {
        let crypt = Crypt(textEncrypted2)
        self.measure {
            XCTAssertEqual(crypt.decrypt(), decrypt2)
        }
    }
}
