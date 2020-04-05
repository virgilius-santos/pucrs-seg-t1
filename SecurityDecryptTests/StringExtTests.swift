
import XCTest
@testable import SecurityDecrypt

class StringExt: XCTestCase {
    
    func test_decrypt() {
        XCTAssertEqual("thissentenceissecret", "tikvweovhrcfkvwedthx".decrypt(key: "abcde"))
        XCTAssertEqual("this", "tikv".decrypt(key: "abcde"))
        XCTAssertEqual(text, textEncrypted.decrypt(key: "abcde"))
    }
    
    func test_encrypt() {
        let e = "thissentenceissecret".encrypt(key: "abcde")
        XCTAssertEqual("tikvweovhrcfkvwedthx", e)
        XCTAssertEqual("tikvweovhrcfkvwedthx".count, e.count)
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
        let frequency: [Character: Int] = frequencies(selfArray: word.array)
        XCTAssertEqual(frequency["a"], 1)
        XCTAssertEqual(frequency["d"], 2)
        XCTAssertEqual(frequency["f"], 3)
        XCTAssertEqual(frequency["g"], 4)
    }
    
    func test_indexOfCoincidence_fromWord() {
        XCTAssertEqual(indexOfCoincidence(selfArray: "".array), 0)
        XCTAssertEqual(indexOfCoincidence(selfArray: "4444".array), 1)
        
        let text: String = self.text.lowercased().alphanumeric
        XCTAssertEqual(indexOfCoincidence(selfArray: text.array), 0.071728, accuracy: 0.00001)
                
        XCTAssertEqual(indexOfCoincidence(selfArray: text1.array), 0.04470, accuracy: 0.0001)
    }
    
    func test_indexOfCoincidence_fromSplittedWord() {
        XCTAssertEqual(indexOfCoincidence(step: 2, word: "45454545"), 1)
        
        XCTAssertEqual(indexOfCoincidence(step: 2, word: text1), 0.0430, accuracy: 0.0001)
        XCTAssertEqual(indexOfCoincidence(step: 3, word: text1), 0.0463, accuracy: 0.0001)
        XCTAssertEqual(indexOfCoincidence(step: 4, word: text1), 0.0413, accuracy: 0.0001)
        XCTAssertEqual(indexOfCoincidence(step: 5, word: text1), 0.0664, accuracy: 0.0001)
        XCTAssertEqual(indexOfCoincidence(step: 6, word: text1), 0.0435, accuracy: 0.0001)
        
        XCTAssertEqual(indexOfCoincidence(step: 4, word: text2), 0.04256, accuracy: 0.0001)
        XCTAssertEqual(indexOfCoincidence(step: 5, word: text2), 0.07093, accuracy: 0.0001)
        XCTAssertEqual(indexOfCoincidence(step: 6, word: text2), 0.0454, accuracy: 0.0001)
        XCTAssertEqual(indexOfCoincidence(step: 10, word: text2), 0.07121, accuracy: 0.0001)
    }
    
    func test_findStepOfIndexOfCoincidence() {
        XCTAssertEqual(self.text1.findFirstClosestndexOfCoincidence(), 5)
        XCTAssertEqual(self.text2.findFirstClosestndexOfCoincidence(), 5)
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
    
    let text2: String = """
cfguscwiawguegfnhxtftiverwhrcjgvgaoqqpycgjpebphhbzcqelzblrgbndvgfcpsuovrjrfruisfpwetjxhxeyvzmtivkiawclpackomtzqiqoegurcposytjpjeneerplfewmoourjlbtjitfzwgosrrvatwflcbnfylbvlsntcuiebulpyncgieycptlfufencggvaxpivoncyerjgwcoguryrdgvtrfuvveqquxioiuiljilsutvhbttufmeovljidvhbttcqhgfphvamhlgtjqqenevkirfcuidjhiirfpfisfusicjcopygqukeoguelgkfxippzmtivkippulxipprjhbpgmwjvklbferqioipsrferqmpp
"""
}
