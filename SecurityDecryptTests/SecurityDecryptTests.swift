
import XCTest
@testable import SecurityDecrypt

class SecurityDecryptTests: XCTestCase {
    
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
    
    func test_vigenereInverted() {
        let matriz: [Character: [Character: Character]] = Crypt.matrizVigenereInverted
        var string = ""
        var aux = ""
        for (_, dict) in matriz.sorted(by: { (v1, v2) -> Bool in v1.key < v2.key }) {
            string += ""
            aux = ""
            for (_, v) in dict.sorted(by: { (v1, v2) -> Bool in v1.key < v2.key }) {
                string += "\(aux)\(v)"
                aux = "\t"
            }
            string += "\n"
        }
        print(string)
    }
}
