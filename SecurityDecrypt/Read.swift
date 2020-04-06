
import Foundation

public class Read {
    /// le o conteudo do arquivo
    /// se os parametros forem invalidos retorna nil
    public static func read(_ file: String, format: String = "txt") -> String? {
        if let path = bundle.path(forResource: file, ofType: format) {
            return try? String(contentsOfFile: path, encoding: .utf8)
        }
        return nil
    }
    
    /// sa;ca o conteudo em um arquivo
    /// se os parametros forem invalidos retorna false
    public static func write(_ file: String, format: String = "txt", content: String) -> Bool {
        if let path = bundle.path(forResource: file, ofType: format) {
            let url = URL(fileURLWithPath: path)
            
            let file = try! FileHandle(forUpdating: url)
            let data = content.data(using: .utf8)!
            
            file.write(data)
            file.closeFile()
            return true
        }
        return false
    }
}
