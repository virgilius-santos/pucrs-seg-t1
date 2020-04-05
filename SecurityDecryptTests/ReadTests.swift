
import XCTest
@testable import SecurityDecrypt

class ReadTests: XCTestCase {

    func test_read() throws {
        XCTAssert(Read.write("String", format: "txt", content: ""))
        XCTAssertEqual(Read.read("String", format: "txt"), "\n")
        XCTAssert(Read.write("String", format: "txt", content: text))
        XCTAssertEqual(Read.read("String", format: "txt"), text)
    }
    
    let text: String = "InBrazilalotofpeopletrytosavetimeInmostfamiliesboththehusbandandthewifeworkfulltimesotheirfreetimeisveryshortandveryimportanttothemTheylookforquickandconvenientwaystodotheirshoppingandotherthingssotheycanhavefreetimetoenjoythemselvesanddothethingstheyreallyliketodoBackinthedaypeopleusedtogotomanydifferentplacestobuythethingstheyneededathomeTheyusedtogotothebutcherformeatandchickentothefruitmarketforfreshfruitandtothebakeryforbreadNowadaysmostpeoplejustgotooneplacetogeteverythingtheyneedTheycanbuyfruitvegetablesbreadmeatmilkandfrozenfoodsattheirlocalsupermarketWhenpeopleeatouttheyoftengotofastfoodrestaurantsTherepeopleordertheirfoodatthecounterandhavetowaitonlyafewsecondsorminutesThentheycarrytheirfoodtoatablesitdowneatitandthrowtheirtrashawaySometimespeopleleavetheirtrashonthetablefortheemployeestocleanupItdoesnttaketoolongtoeatamealatafastfoodrestaurantbutitsnotalwaysahealthychoice\n"
}
