
import XCTest
@testable import SecurityDecrypt

class ReadTests: XCTestCase {

    var sut: Read!
    
    override func setUpWithError() throws {
        sut = .init()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_read() throws {
        var read: String!
        XCTAssertNoThrow(read = try sut.read("String", format: "txt") )
        XCTAssertEqual(read, text)
        
        XCTAssertNil(try? sut.read("na", format: "txt"))
    }
    
    let text: String = "InBrazilalotofpeopletrytosavetimeInmostfamiliesboththehusbandandthewifeworkfulltimesotheirfreetimeisveryshortandveryimportanttothemTheylookforquickandconvenientwaystodotheirshoppingandotherthingssotheycanhavefreetimetoenjoythemselvesanddothethingstheyreallyliketodoBackinthedaypeopleusedtogotomanydifferentplacestobuythethingstheyneededathomeTheyusedtogotothebutcherformeatandchickentothefruitmarketforfreshfruitandtothebakeryforbreadNowadaysmostpeoplejustgotooneplacetogeteverythingtheyneedTheycanbuyfruitvegetablesbreadmeatmilkandfrozenfoodsattheirlocalsupermarketWhenpeopleeatouttheyoftengotofastfoodrestaurantsTherepeopleordertheirfoodatthecounterandhavetowaitonlyafewsecondsorminutesThentheycarrytheirfoodtoatablesitdowneatitandthrowtheirtrashawaySometimespeopleleavetheirtrashonthetablefortheemployeestocleanupItdoesnttaketoolongtoeatamealatafastfoodrestaurantbutitsnotalwaysahealthychoice\n"
}
