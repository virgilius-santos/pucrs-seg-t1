
import XCTest
@testable import SecurityDecrypt

class Performance: XCTestCase {

    func testPerformanceExample() throws {
        self.measure {
            XCTAssertEqual(Main.decrypt(crypt: textEncrypted), text)
        }
    }

}
