import Foundation
import FirebaseAnalytics

protocol FBAnalyticsProtocol {
    static func logScreenName()
    static func logFunctionName(method: String)
    static func logEvent(method: String)
}

struct FBAnalytics: FBAnalyticsProtocol {
    
    static func logScreenName() {
        Analytics.logEvent(AnalyticsEventScreenView,
                           parameters: [AnalyticsParameterScreenName: "screenName",
                                       AnalyticsParameterScreenClass: "screenClass"])
    }
    
    static func logFunctionName(method: String) {
        Analytics.logEvent(AnalyticsParameterMethod,
                           parameters: [AnalyticsParameterMethod: method,
                                   AnalyticsParameterScreenClass: "screenClass"])
    }
    
    static func logEvent(method: String) {
        Analytics.logEvent(AnalyticsEventSelectContent,
                           parameters: [AnalyticsParameterScreenName: "screenName",
                                            AnalyticsParameterMethod: method,
                                            AnalyticsParameterItemID: "ItemID",
                                          AnalyticsParameterItemName: "Title",
                                       AnalyticsParameterContentType: "Something"])
    }
}
