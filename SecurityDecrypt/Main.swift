
import Foundation

public class Main {
    public static func decrypt(crypt: String) -> String {
        Crypt(crypt).decrypt()
    }
    
    public static func encrypt(crypt: String, key: String) -> String {
        Crypt(crypt, key: key).encrypt()
    }
}
