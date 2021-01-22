struct Users: Codable, Equatable {
    var id: Int64
    var email, first_name, last_name, avatar: String
}

struct LoginModel: Codable {
    var data: [Users]
}
