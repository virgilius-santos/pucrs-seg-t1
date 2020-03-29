
import XCTest
@testable import SecurityDecrypt

class StringExt: XCTestCase {
    
    func test_decrypt() {
        XCTAssertEqual("thissentenceissecret", "tikvweovhrcfkvwedthx".decrypt(key: "abcde"))
        XCTAssertEqual("this", "tikv".decrypt(key: "abcde"))
        XCTAssertEqual(text, textEncrypted.decrypt(key: "abcde"))
    }
    
    func test_encrypt() {
        XCTAssertEqual("tikvweovhrcfkvwedthx", "thissentenceissecret".encrypt(key: "abcde"))
        XCTAssertEqual(textEncrypted, text.encrypt(key: "abcde"))
         XCTAssertEqual("tikv", "this".encrypt(key: "abcde"))
    }
    
    func test_alphanumeric() {
        let word: String = "asdfg2345678';/.,][\n\t"
        XCTAssertEqual("asdfg2345678", word.alphanumeric)
    }
    
    func test_substring() {
        XCTAssertEqual("123412341234".substring(), "123412341234")
        XCTAssertEqual("123412341234".substring(step: 2), "131313")
        XCTAssertEqual("123412341234".substring(step: 3), "1432")
    }
    
    func test_substrings() {
        XCTAssertEqual("1212".substrings(step: 2)[0], "11")
        XCTAssertEqual("1212".substrings(step: 2)[1], "22")
        XCTAssertEqual("12121".substrings(step: 2)[0], "111")
        
        XCTAssertEqual("thissentenceissecret".substrings(step: 5)[0], "tece")
        XCTAssertEqual("thissentenceissecret".substrings(step: 5)[1], "hnec")
        XCTAssertEqual("thissentenceissecret".substrings(step: 5)[2], "itir")
        XCTAssertEqual("thissentenceissecret".substrings(step: 5)[3], "sese")
        XCTAssertEqual("thissentenceissecret".substrings(step: 5)[4], "snst")
    }
    
    func test_frequency() {
        let word: String = "addfffgggg"
        let frequency: [String: Int] = word.frequencies()
        XCTAssertEqual(frequency["a"], 1)
        XCTAssertEqual(frequency["d"], 2)
        XCTAssertEqual(frequency["f"], 3)
        XCTAssertEqual(frequency["g"], 4)
    }
    
    func test_indexOfCoincidence_fromWord() {
        XCTAssertEqual("".indexOfCoincidence(), 0)
        XCTAssertEqual("4444".indexOfCoincidence(), 1)
        
        let text: String = self.text.lowercased().alphanumeric
        XCTAssertEqual(text.indexOfCoincidence(), 0.071728, accuracy: 0.00001)
                
        XCTAssertEqual(text1.indexOfCoincidence(), 0.04470, accuracy: 0.0001)
    }
    
    func test_indexOfCoincidence_fromSplittedWord() {
        XCTAssertEqual("45454545".indexOfCoincidence(step: 2), 1)
        
        XCTAssertEqual(text1.indexOfCoincidence(step: 2), 0.0430, accuracy: 0.0001)
        XCTAssertEqual(text1.indexOfCoincidence(step: 3), 0.0463, accuracy: 0.0001)
        XCTAssertEqual(text1.indexOfCoincidence(step: 4), 0.0413, accuracy: 0.0001)
        XCTAssertEqual(text1.indexOfCoincidence(step: 5), 0.0664, accuracy: 0.0001)
        XCTAssertEqual(text1.indexOfCoincidence(step: 6), 0.0435, accuracy: 0.0001)
    }
    
    func test_findStepOfIndexOfCoincidence() {
        XCTAssertEqual(self.text1.findStepOfIndexOfCoincidence(), 5)
    }
    
    func test_indexOfCosincidence_fromSplittedWord() {
        let ics: [Double] = text1.generateIndexOfCoincidence(qtd: 6)
        
        XCTAssertEqual(ics.count, 6)
        XCTAssertEqual(ics[0], 0.0447, accuracy: 0.0001)
        XCTAssertEqual(ics[1], 0.0430, accuracy: 0.0001)
        XCTAssertEqual(ics[2], 0.0463, accuracy: 0.0001)
        XCTAssertEqual(ics[3], 0.0413, accuracy: 0.0001)
        XCTAssertEqual(ics[4], 0.0664, accuracy: 0.0001)
        XCTAssertEqual(ics[5], 0.0435, accuracy: 0.0001)
    }
    
    
    let text: String = "inbrazilalotofpeopletrytosavetimeinmostfamiliesboththehusbandandthewifeworkfulltimesotheirfreetimeisveryshortandveryimportanttothemtheylookforquickandconvenientwaystodotheirshoppingandotherthingssotheycanhavefreetimetoenjoythemselvesanddothethingstheyreallyliketodobackinthedaypeopleusedtogotomanydifferentplacestobuythethingstheyneededathometheyusedtogotothebutcherformeatandchickentothefruitmarketforfreshfruitandtothebakeryforbreadnowadaysmostpeoplejustgotooneplacetogeteverythingtheyneedtheycanbuyfruitvegetablesbreadmeatmilkandfrozenfoodsattheirlocalsupermarketwhenpeopleeatouttheyoftengotofastfoodrestaurantstherepeopleordertheirfoodatthecounterandhavetowaitonlyafewsecondsorminutesthentheycarrytheirfoodtoatablesitdowneatitandthrowtheirtrashawaysometimespeopleleavetheirtrashonthetablefortheemployeestocleanupitdoesnttaketoolongtoeatamealatafastfoodrestaurantbutitsnotalwaysahealthychoice"
    
    let textEncrypted: String = "ioduezjndpouqiteproitsawssbxhxinglrmpuwjankometdrxhujhlutddrdbpgxhfyljexquofvnoxingvstiglvfsghxinglwvftbwhptwenexhvyjossrucqxtpvkimujhclpqnjossxmclcqhcppyinjgqxwbavxoeqwlejtvloqrlrgbpgstiguxhjpjwspvkiydcqlawgivefvlqeuqhrjpawlenuhpvfudrdeqwleujlrgtvkiysgdplznloeuqgsbbenmnujhhazrhspmgxweevrkouqpenzfljffthrtqndgetvrfuzvkitikqksujhcnfggidbvksmfvkiyvuhhtpirxoujhfuuekirgquqebvdrddjlgkfpwstigivujvperlgwjoshuisihuyiucqhtpvkibbmhvygqufrfcgroxcgeytorwtqgrtlflxwthqwsoogspadgwsgfvhzesawlioiwlezphidujhccbpeyygtxmtwgjitbdoiscthedngdxmjnnenehuszfpisoeudxtiglvlpedpsvrhvmbtnitxjhrpfqspefcwsuuvkiyphwinhqwsfbuwjopfuisucxvaovvxhfthteproiosfhvtiglvfpqgetujhgovpwirbpglawgwswbkwsnmadjexuhgoofvsrnkqytfuwleovkiydcuvyujhmrgqrhtpcwebmgvmteqzrebvlxaofwlrpywlejtwvatjdaazurqeukpisqgrtlfnhevfvkiisvuesiqqxhfvdflfhrvtighqpmqbietvrglfcqypjvgsetpwxalgwsomqqktpgdxangdpauciesuhrsdsgvxavtdrtcwwmttprxamydcsbjhelujbghpkfi"
    
    let text1: String = "CHREEVOAHMAERATBIAXXWTNXBEEOPHBSBQMQEQERBWRVXUOAKXAOSXXWEAHBWGJMMQMNKGRFVGXWTRZXWIAKLXFPSKAUTEMNDCMGTSXMXBTUIADNGMGPSRELXNJELXVRVPPTULHDNQWTWDTYGBPHXTFALJHASVBFXNGLLCHRZBWELEKMSJIKNBHWRJGNMGJSGLXFEYPHAGNRBIEQJTAMRVLCRREMNDGLXRRIMGNSNRWCHRQHAEYEVTAQEBBIPEEWEVKAKOEWADREMXMTBHHCHRTKDNVRZCHRCLQOHPWQAIIWXNRMGWOIIFKEE"
}
