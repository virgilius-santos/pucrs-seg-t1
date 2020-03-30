
import XCTest
@testable import SecurityDecrypt

class MainTests: XCTestCase {

    func test_decrypt() {
        XCTAssertEqual(Main.decrypt(crypt: textEncrypted), text)
    }

    let textEncrypted: String = """
wtmohjhsfpoojyawrjlvmzfrisxerzzkqnaatjvrwgzhyfoquklnpbuwhseuwjmaazkunawxrulhumcdsyzrhlkltvdjnhyhrcgowyyvskglqzgvcemmscqazgrgowcgakkcceldutrzaiijplnrulezfrvsxqjljkqvsnkpjoaifgvlncgbfkmsmdarrzckngzlxmxlstbzhvkrulogrryongpolncliwgrgvxujyvolyfawxyfheupbbkudgowopfajuirzxupuljuuawwxqbuazzrnygpqhdrbrzuxgcaaulfowjgqsakgaowxnncargbuurmgoglebsvudgpkysrvwxnvjlapvuyzfnanklhzoncelokqrllncshfiwbblcmerfgrhywulrhunqvkwncezlumqwjkrgfvokcswjzbfkrgxlksgypfmahwajqjplnbvcwxqpvdusekxglfdzuqrdatbqpvycrtlueyvozfrkwrgphlkaulwqqjoaifgowebvkuumyhfjuuhlzfrfmtbvkvobnnjonchgxyelxupnululllfuznytaquljmcaadkubtwtjvrwzfruwxcvkwyqbtstwzljsyvkkzcakwjfryazfrfwyyakegbrazkgeiwtbfhvupapfmqnalnculdsyflwsganekpzhajqglwxqgowygyrwtrnjcrcfdwrjjplnrulluspowymsazuqrmduurykudgostbfazgrlhjkjlmjgkrazkmsmaicsygsrultgptlsyrehfmcvunoqvidknryxakroazqgowycazwudgowgbwhuklgdzgpszlncppleanzlncewwunylgarhwgtfrystbnululllfzfevfkbvazsyerwznyhukbvkkornsgtcjoayrypfmrbazggedzoauimzdbynganuuefnkyulragmymlgtaylgvygyszmbhfjknkwgenwatlnamxcnnjonchjgprlyengpstcavtgpobkanbuzkpyhfjganstrbuqycaalufryattvawjfryluqhwhkpfowxccsakbvaknmhsvhcollzceowhcphekfryyacfaongpokncrulxcnawjmhyuuseawusfhfzmafonmzuwkpgowcmekgllbdgsyaowgpqzhkyxiwoltisxzrywjrrulokrzgkptvwyrbazkdrhkzyakxupupkupqpfgplwsequpkncnyllmedzgrupkkwrzwgrbudeytyavnnygeyydwtauzzkknkwmprhliyrzsxjnfzoqfdgxbgvtkbulhrmjlvncehfjquluxmcwwjcavtgpobkoqndzkpbuukfbwxupgfhgarzlnpbbynrulhazypuyrelwzyakzgtvuyrmfazkpoywgruzzkqcvckyakhglglvzfnakncqpvsyxlvkdrjlvcemwirvvfglqijkygodkqfwgcpoywgrulxupgoegcplfgqavoglgvfekhzlrcncwnceblzcesqklbisxzhzfktryzkuvsdtmghykanufurjplnceowxlbyuaqgveyrnswncepflgaplktnyakrlvlncedgscajduwgowgncllorrzlnclmwkboblyfrtsqcfomteefonceleuqgzzkqnaaydvlklmecarcfalngankhcpvekruleycycwygaowxruhlzfrogrwcyakqgztrcfzzkpjowtqulaypvnyoqu
"""
    
    
    let text: String = """
enobarbusiwilltellyouthebargeshesatinlikeaburnishdthroneburnedonthewaterthepoopwasbeatengoldpurplethesailsandsoperfumedthatthewindswerelovesickwiththemtheoarsweresilverwhichtothetuneoffluteskeptstrokeandmadethewaterwhichtheybeattofollowfasterasamorousoftheirstrokesforherownpersonitbeggardalldescriptionshedidlieinherpavilionclothofgoldoftissueoerpicturingthatvenuswhereweseethefancyoutworknatureoneachsideherstoodprettydimpledboyslikesmilingcupidswithdiverscolourdfanswhosewinddidseemtoglowthedelicatecheekswhichtheydidcoolandwhattheyundiddidagrippaorareforantonyenobarbushergentlewomenlikethenereidessomanymermaidstendedheritheyesandmadetheirbendsadorningsatthehelmaseemingmermaidsteersthesilkentackleswellwiththetouchesofthoseflowersofthandsthatyarelyframetheofficefromthebargeastrangeinvisibleperfumehitsthesenseoftheadjacentwharfsthecitycastherpeopleoutuponherandantonyenthronedithmarketplacedidsitalonewhistlingtothairwhichbutforvacancyhadgonetogazeoncleopatratooandmadeagapinnatureagripparareegyptianenobarbusuponherlandingantonysenttoherinvitedhertosuppershereplieditshouldbebetterhebecameherguestwhichsheentreatedourcourteousantonywhomneerthewordofnowomanheardspeakbeingbarberedtentimesoergoestothefeastandforhisordinarypayshisheartforwhathiseyeseatonlyagripparoyalwenchshemadegreatcaesarlayhisswordtobedheplowedherandshecroppedenobarbusisawheroncehopfortypacesthroughthepublicstreetandhavinglostherbreathshespokeandpantedthatshedidmakedefectperfectionandbreathlesspowrbreatheforthmaecenasnowantonymustleaveherutterlyenobarbusneverhewillnotagecannotwitherhernorcustomstaleherinfinitevarietyotherwomencloytheappetitestheyfeedbutshemakeshungrywheremostshesatisfiesforvilestthingsbecomethemselvesinherthattheholypriestsblessherwhensheisriggish
"""

}
