import UIKit

struct Countries: Codable {
    
    var name: String
    var dial_code: String
    var code: String
    
    static func fetchObject(code: String) -> Countries? {
        if let path = Bundle.main.path(forResource: "CountryCode", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
                let countryObj = try JSONDecoder().decode([Countries].self, from: data)
                return countryObj.first(where:{$0.code == code})
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return nil
    }
}
