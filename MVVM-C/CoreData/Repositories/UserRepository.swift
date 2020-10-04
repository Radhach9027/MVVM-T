import Foundation
import CoreData

protocol UserRepository: BaseRepository{}

struct UserDataRepository : UserRepository {
    
    typealias T = Users
    
    func create(record: Users) {
        
        let user = User(context: PersistentStorage.shared.context)
        user.id = record.id
        user.email = record.email
        user.first_name = record.first_name
        user.last_name = record.last_name
        user.avatar = record.avatar
        
        PersistentStorage.shared.saveContext()
    }
    
    func get(byIdentifier id: Int64) -> Users? {
        
        let result = getUser(byIdentifier: id)
        guard result != nil else {return nil}
        return nil
    }
    
    @discardableResult
    func update(record: Users) -> Bool {
        
        let user = getUser(byIdentifier: record.id)
        guard user != nil else {return false}
        
        user?.id = record.id
        user?.email = record.email
        user?.first_name = record.first_name
        user?.last_name = record.last_name
        user?.avatar = record.avatar
        
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(byIdentifier id: Int64) -> Bool {
        
        let user = getUser(byIdentifier: id)
        guard user != nil else {return false}
        
        PersistentStorage.shared.context.delete(user!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    private func getUser(byIdentifier id: Int64) -> User? {
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        let predicate = NSPredicate(format: "id==%@", id)
        
        fetchRequest.predicate = predicate
        do {
            if let result = try PersistentStorage.shared.context.fetch(fetchRequest).first {
                return result
            }
            return nil
        } catch let error {
            debugPrint(error)
        }
        
        return nil
    }
}

