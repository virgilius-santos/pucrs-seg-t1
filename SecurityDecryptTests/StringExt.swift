
import XCTest
@testable import SecurityDecrypt

class StringExt: XCTestCase {

    func test_alphanumeric() {
        let word: String = "asdfg2345678';/.,][\n\t"
        XCTAssertEqual("asdfg2345678", word.alphanumeric)
    }
    
    func test_substring() {
        
        let word: String = "123412341234"
        XCTAssertEqual(word.substring(), word)
        XCTAssertEqual(word.substring(step: 2), "131313")
        XCTAssertEqual(word.substring(step: 3), "1432")
        
        let substrings = "1212".substrings(step: 2)
        XCTAssertEqual(substrings[0], "11")
        XCTAssertEqual(substrings[1], "22")
    }
    
    func test_frequency() {
        let word: String = "addfffgggg"
        let frequency: [String: Int] = word.frequencies()
        XCTAssertEqual(frequency["a"], 1)
        XCTAssertEqual(frequency["d"], 2)
        XCTAssertEqual(frequency["f"], 3)
        XCTAssertEqual(frequency["g"], 4)
        
        XCTAssertEqual(frequency.total, word.count)
    }
    
    func test_indexOfCoincidence() {
        XCTAssertEqual("".indexOfCoincidence(), 0)
        XCTAssertEqual("4444".indexOfCoincidence(), 1)
        XCTAssertEqual("45454545".indexOfCoincidence(step: 2), 1)
        
        let text: String = self.text.lowercased().alphanumeric
        XCTAssertEqual(text.indexOfCoincidence(), 0.071728, accuracy: 0.00001)
        
        let text1: String = self.text1
        XCTAssertEqual(text1.indexOfCoincidence(), 0.04470, accuracy: 0.0001)
        XCTAssertEqual(text1.indexOfCoincidence(step: 2), 0.0430, accuracy: 0.0001)
        XCTAssertEqual(text1.indexOfCoincidence(step: 3), 0.0463, accuracy: 0.0001)
        XCTAssertEqual(text1.indexOfCoincidence(step: 4), 0.0413, accuracy: 0.0001)
        XCTAssertEqual(text1.indexOfCoincidence(step: 5), 0.0664, accuracy: 0.0001)
        XCTAssertEqual(text1.indexOfCoincidence(step: 6), 0.0435, accuracy: 0.0001)
    }
    
    let text: String = "InBrazilalotofpeopletrytosavetimeInmostfamiliesboththehusbandandthewifeworkfulltimesotheirfreetimeisveryshortandveryimportanttothemTheylookforquickandconvenientwaystodotheirshoppingandotherthingssotheycanhavefreetimetoenjoythemselvesanddothethingstheyreallyliketodoBackinthedaypeopleusedtogotomanydifferentplacestobuythethingstheyneededathomeTheyusedtogotothebutcherformeatandchickentothefruitmarketforfreshfruitandtothebakeryforbreadNowadaysmostpeoplejustgotooneplacetogeteverythingtheyneedTheycanbuyfruitvegetablesbreadmeatmilkandfrozenfoodsattheirlocalsupermarketWhenpeopleeatouttheyoftengotofastfoodrestaurantsTherepeopleordertheirfoodatthecounterandhavetowaitonlyafewsecondsorminutesThentheycarrytheirfoodtoatablesitdowneatitandthrowtheirtrashawaySometimespeopleleavetheirtrashonthetablefortheemployeestocleanupItdoesnttaketoolongtoeatamealatafastfoodrestaurantbutitsnotalwaysahealthychoice"
    
    let text1: String = "CHREEVOAHMAERATBIAXXWTNXBEEOPHBSBQMQEQERBWRVXUOAKXAOSXXWEAHBWGJMMQMNKGRFVGXWTRZXWIAKLXFPSKAUTEMNDCMGTSXMXBTUIADNGMGPSRELXNJELXVRVPPTULHDNQWTWDTYGBPHXTFALJHASVBFXNGLLCHRZBWELEKMSJIKNBHWRJGNMGJSGLXFEYPHAGNRBIEQJTAMRVLCRREMNDGLXRRIMGNSNRWCHRQHAEYEVTAQEBBIPEEWEVKAKOEWADREMXMTBHHCHRTKDNVRZCHRCLQOHPWQAIIWXNRMGWOIIFKEE"
}
