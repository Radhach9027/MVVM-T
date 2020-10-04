import Foundation
import CoreLocation
import UIKit

class LocationManager: NSObject {
    
    private static var sharedInstance: LocationManager?
    class var shared : LocationManager {
        
        guard let instance = self.sharedInstance else {
            let strongInstance = LocationManager()
            self.sharedInstance = strongInstance
            return strongInstance
        }
        return instance
    }
    
    class func destroy() {
        sharedInstance = nil
    }
}
