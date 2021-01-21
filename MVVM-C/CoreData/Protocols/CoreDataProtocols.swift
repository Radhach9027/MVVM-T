protocol BaseRepository {
    associatedtype T
    func create(record: T)
    func get(byIdentifier id: Int64) -> T?
    func update(record: T) -> Bool
    func delete(byIdentifier id: Int64) -> Bool
}

protocol UserManagerProtocol {
    func createUser(endUser: Users)
    func fetchUser(byIdentifier id: Int64) -> Users?
    @discardableResult
    func updateUser(endUser: Users) -> Bool
    func deleteUser(id: Int64) -> Bool
}

protocol UserRepository: BaseRepository{}




