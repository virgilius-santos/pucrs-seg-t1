
import Foundation
import SecurityDecrypt

print(Main.decrypt(crypt: (try? Read.read("String", format: "txt"))?.alphanumeric.lowercased() ?? "") )
