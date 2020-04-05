
import XCTest
@testable import SecurityDecrypt

class StringExt: XCTestCase {
    
    func test_decrypt() {
        XCTAssertEqual("thissentenceissecret", "tikvweovhrcfkvwedthx".crypt.decrypt(key: "abcde".array))
//        XCTAssertEqual("this", "tikv".crypt.decrypt(key: "abcde".array))
//        XCTAssertEqual(text, textEncrypted.crypt.decrypt(key: "abcde".array))
    }
    
    func test_encrypt() {
        let e = "thissentenceissecret".crypt.encrypt(key: "abcde".array)
        XCTAssertEqual("tikvweovhrcfkvwedthx", e)
        XCTAssertEqual("tikvweovhrcfkvwedthx".count, e.count)
        XCTAssertEqual(textEncrypted, text.crypt.encrypt(key: "abcde".array))
         XCTAssertEqual("tikv", "this".crypt.encrypt(key: "abcde".array))
    }
    
    func test_alphanumeric() {
        let word: String = "asdfg2345678';/.,][\n\t"
        XCTAssertEqual("asdfg2345678", word.alphanumeric)
    }
    
    func test_frequency() {
        let frequency: [Character: Int] = "addfffgggg".array.frequencies()
        XCTAssertEqual(frequency["a"], 1)
        XCTAssertEqual(frequency["d"], 2)
        XCTAssertEqual(frequency["f"], 3)
        XCTAssertEqual(frequency["g"], 4)
    }
    
    func test_indexOfCoincidence_fromWord() {
        XCTAssertEqual("".crypt.indexOfCoincidence(), 0)
        XCTAssertEqual("hhhh".crypt.indexOfCoincidence(), 1)
        
        let text: String = self.text.lowercased().alphanumeric
        XCTAssertEqual(text.crypt.indexOfCoincidence(), 0.071728, accuracy: 0.00001)
        XCTAssertEqual(text1.crypt.indexOfCoincidence(), 0.04470, accuracy: 0.0001)
    }
    
    func test_indexOfCoincidence_fromSplittedWord() {
        XCTAssertEqual("ababababab".crypt.indexOfCoincidence(step: 2), 1)
        
        XCTAssertEqual(text1.crypt.indexOfCoincidence(step: 2), 0.0430, accuracy: 0.0001)
        XCTAssertEqual(text1.crypt.indexOfCoincidence(step: 3), 0.0463, accuracy: 0.0001)
        XCTAssertEqual(text1.crypt.indexOfCoincidence(step: 4), 0.0413, accuracy: 0.0001)
        XCTAssertEqual(text1.crypt.indexOfCoincidence(step: 5), 0.0664, accuracy: 0.0001)
        XCTAssertEqual(text1.crypt.indexOfCoincidence(step: 6), 0.0435, accuracy: 0.0001)
        
        XCTAssertEqual(text2.crypt.indexOfCoincidence(step: 4), 0.04256, accuracy: 0.0001)
        XCTAssertEqual(text2.crypt.indexOfCoincidence(step: 5), 0.07093, accuracy: 0.0001)
        XCTAssertEqual(text2.crypt.indexOfCoincidence(step: 6), 0.0454, accuracy: 0.0001)
        XCTAssertEqual(text2.crypt.indexOfCoincidence(step: 10), 0.07121, accuracy: 0.0001)
    }
    
    func test_findStepOfIndexOfCoincidence() {
        XCTAssertEqual(text1.crypt.findFirstClosestIndexOfCoincidence(), 5)
        XCTAssertEqual(text2.crypt.findFirstClosestIndexOfCoincidence(), 5)
    }
    
    func test_indexOfCosincidence_fromSplittedWord() {
        let ics: [Double] = text1.crypt.generateIndexOfCoincidence(qtd: 6)
        
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
    
    let text1: String = "CHREEVOAHMAERATBIAXXWTNXBEEOPHBSBQMQEQERBWRVXUOAKXAOSXXWEAHBWGJMMQMNKGRFVGXWTRZXWIAKLXFPSKAUTEMNDCMGTSXMXBTUIADNGMGPSRELXNJELXVRVPPTULHDNQWTWDTYGBPHXTFALJHASVBFXNGLLCHRZBWELEKMSJIKNBHWRJGNMGJSGLXFEYPHAGNRBIEQJTAMRVLCRREMNDGLXRRIMGNSNRWCHRQHAEYEVTAQEBBIPEEWEVKAKOEWADREMXMTBHHCHRTKDNVRZCHRCLQOHPWQAIIWXNRMGWOIIFKEE".lowercased()
    
    let text2: String = """
    cfguscwiawguegfnhxtftiverwhrcjgvgaoqqpycgjpebphhbzcqelzblrgbndvgfcpsuovrjrfruisfpwetjxhxeyvzmtivkiawclpackomtzqiqoegurcposytjpjeneerplfewmoourjlbtjitfzwgosrrvatwflcbnfylbvlsntcuiebulpyncgieycptlfufencggvaxpivoncyerjgwcoguryrdgvtrfuvveqquxioiuiljilsutvhbttufmeovljidvhbttcqhgfphvamhlgtjqqenevkirfcuidjhiirfpfisfusicjcopygqukeoguelgkfxippzmtivkippulxipprjhbpgmwjvklbferqioipsrferqmpp
    """.lowercased()
}
