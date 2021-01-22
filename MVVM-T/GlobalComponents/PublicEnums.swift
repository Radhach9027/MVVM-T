import UIKit

enum ValidationMessages: String {
    case noPassword = "Please enter a password"
    case validPassword = "Password length should be greater than or equal to 8 charcters & should contain atleast one special char, numeric, uppercase, lowercase"
    case noEmail = "Please enter email"
    case validEmail = "Please enter a valid email address"
    case noPhone = "Please enter phone number"
    case validPhone = "Please enter a valid phone number"
    case passwordNotMatch = "Please check the password you've entered, try again.."
    case globalNoValue = "Please enter an email or phone or userName"
}

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

enum AnimatePosition {
    case top, bottom, middle
}

enum NetworkMessages: String {
    
    case internet = "Hey Seems to have good internet connectivity..Let's ride the app..😃"
    case noInternet = "As it seems there is no network connection available on the device, please check and try again..😟"
    case error = "Oops...Something went wrong, Please try again."
    
    func AnimatedIcons () -> UIImage {
        switch self {
        case .noInternet:
            return UIImage(named: "NoInternet")!
        case .internet:
            return UIImage(named: "Internet")!
        case .error:
            return UIImage(named: "error")!
        }
    }
    
    enum ApiError {
        case api(Error)

        func errorMessages() -> String {
            switch self {
            case let .api(error):
                return error.localizedDescription
            }
        }
    }
}

enum Transform {
    case show
    case hide
}

enum LoadingSteps {
    case start(animate: Bool)
    case end
    case success(animate: Bool)
    case failure(animate: Bool)
}

enum CustomPopupAnimateOptions {
    case affineIn
    case crossDisolve
    case affineOut
    case bounce
}

enum UIDeviceSize  {
    case i3_5Inch
    case i4Inch
    case i4_7Inch
    case i5_5Inch
    case i5_8Inch
    case i6_1Inch
    case i6_5Inch
    case i7_9Inch
    case i9_7Inch
    case i10_5Inch
    case i12_9Inch
    case unknown
}

enum PopupListTypes: String {
    case City
    case State
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
