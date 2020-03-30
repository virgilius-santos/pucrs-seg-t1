
import XCTest
@testable import SecurityDecrypt

class SecurityDecryptTests: XCTestCase {

    var sut: Crypt!
    
    override func setUpWithError() throws {
        sut = .init()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_alphabet() throws {
        XCTAssertEqual(Crypt.alphabet.count, 26)
    }
    
    func test_vigenere() {
        let matriz: [Character: [Character]] = Crypt.matrizVigenere
        XCTAssertEqual(matriz.count, 26)
        for (i, array) in matriz.sorted(by: { $0.key < $1.key}) {
            XCTAssertEqual(array.count, 26)
            XCTAssertEqual(array[0], i)
        }
    }
}
