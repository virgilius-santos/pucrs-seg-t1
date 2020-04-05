
import XCTest
@testable import SecurityDecrypt

class PerfTests: XCTestCase {

    func testPerformanceExample() throws {
        let textEncrypted: String = Read.read("String2", format: "txt")!.alphanumeric.lowercased()
//        self.measure {
//            XCTAssert(Main.decrypt(crypt: textEncrypted).count > 0)
//        }
        let decrypt = Main.decrypt(crypt: textEncrypted)
        XCTAssert(Read.write("String3", format: "txt", content: decrypt))
    }

}
