import Foundation
import FirebaseAnalytics

protocol FBAnalyticsProtocol {
    func logScreenName()
    func logFunctionName(method: String)
    func logEvent(method: String)
}

struct FBAnalytics: FBAnalyticsProtocol {
    
    func logScreenName() {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [AnalyticsParameterScreenName: "screenName", AnalyticsParameterScreenClass: "screenClass"])
    }
    
    func logFunctionName(method: String) {
        Analytics.logEvent(AnalyticsParameterMethod, parameters: [AnalyticsParameterMethod: method, AnalyticsParameterScreenClass: "screenClass"])
    }
    
    func logEvent(method: String) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [AnalyticsParameterScreenName: "screenName", AnalyticsParameterMethod: method, AnalyticsParameterItemID: "ItemID", AnalyticsParameterItemName: "Title", AnalyticsParameterContentType: "Something"])
    }
}
