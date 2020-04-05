
import Foundation
import SecurityDecrypt

print(Main.decrypt(crypt: (Read.read("String", format: "txt"))?.alphanumeric.lowercased() ?? "") )
