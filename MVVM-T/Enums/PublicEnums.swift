import UIKit

enum UserDefaultsKeys: String {
    case storeStack
}

enum BarButtonImageType: String {
    case notification
    case settings
    case userImage
}

enum BarButtonItemPosition {
    case right, left
}

enum BarButtonItemType {
    case notification(BarButtonItemPosition)
}

public enum UIButtonBorderSide {
    case Top, Bottom, Left, Right
}

enum AppFontSize: CGFloat {
    case tabs = 11.0
    case small = 12.0
    case regular  = 16.0
    case heavy = 17.0
    case light = 14.0
    case navTitle = 18.0
}

enum AppFontName: String {
    case regular = "KohinoorTelugu-Regular"
    case medium = "KohinoorTelugu-Medium"
    case bold = "KohinoorGujarati-Bold"
    case light = "KohinoorTelugu-Light"
    case semiBold = "KohinoorDevanagari-Semibold"
}

enum Transform {
    case show
    case hide
}

enum GenderSpecification: String {
    case gender = "Gender Specifications"
    case male = "Male"
    case female = "Female"
    case donotSpecify = "I prefer not to say"
}

enum ProfileServiceCases {
    case create
}

enum GoogleSignInMessages: String {
    case noUserExists = "The user has not signed in before or they have since signed out."
    case userFailure = "Authentication Success, but unable to fetch user..!"
}

enum SocialSignInType: String, Codable {
    case google
    case apple
    case facebook
    case twitter
    case microsoft
    case github
}

enum FirebaseKeys: String {
    case signInType
}

enum AppleSignInMessages: String {
    case invalid = "Invalid state: A login callback was received, but no login request was sent."
    case tokenNotFound = "Unable to fetch identity token"
    case notSerialized = "Unable to serialize token string from data:"
    case somethingWrong = "Something went wrong ApplesignIn authResult"
}

enum TwitterKeys: String {
    case consumerKey = "dpKWvRRYZXBTdhbRZq3WE1GEK"
    case consumerSecret = "yLNf9OJwbzTrkV1iyXFpSb3AFz44e9hK4VqTkG8zHPsp3yEgUd"
}

enum RandomGeneratorKey: String {
    case key = "0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._"
}
