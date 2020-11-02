import Foundation

protocol UserManagerProtocol {
    func createUser(endUser: Users)
    func fetchUser(byIdentifier id: Int64) -> Users?
    @discardableResult
    func updateUser(endUser: Users) -> Bool
    func deleteUser(id: Int64) -> Bool
}

struct UserManager: UserManagerProtocol {
    
    private let userRepository = UserDataRepository()
    
    func createUser(endUser: Users) {
        userRepository.create(record: endUser)
    }
    
    func fetchUser(byIdentifier id: Int64) -> Users? {
        return userRepository.get(byIdentifier: id)
    }
    
    @discardableResult
    func updateUser(endUser: Users) -> Bool {
        return userRepository.update(record: endUser)
    }
    
    func deleteUser(id: Int64) -> Bool {
        return userRepository.delete(byIdentifier: id)
    }
}

