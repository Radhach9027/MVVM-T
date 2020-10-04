import Foundation

extension JSONSerialization {
    
    static func convertObjectToData(jsonObject: [String: Any]) -> (Data?, NetworkErrorCode?) {
        
        let valid = JSONSerialization.isValidJSONObject(jsonObject)
        
        if valid {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                return (jsonData, nil)
            } catch {
                return (nil, .jsonConversionFailure)
            }
        } else {
            return (nil, .jsonConversionFailure)
        }
    }
}
