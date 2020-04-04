
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
        let matriz: [Character: [Character: Character]] = Crypt.matrizVigenere
        XCTAssertEqual(matriz.count, 26)
        for (k, dict) in matriz {
            XCTAssertEqual(dict.count, 26, "\(k)")
        }
        let a: [Character] = Crypt.alphabet
        for i in 0..<26 {
            for j in 0..<26 {
                XCTAssertEqual(matriz[a[i]]![a[j]], a[(i+j)%26])
            }
        }
    }
}
