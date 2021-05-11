import UIKit

public struct Countries: Codable {
    
    public var name: String
    public var dial_code: String
    public var code: String
    
    public init(name: String, dail_code: String, code: String) {
        self.name = name
        self.dial_code = dail_code
        self.code = code
    }
    
    public static func fetchObject(code: String) -> Countries? {
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
