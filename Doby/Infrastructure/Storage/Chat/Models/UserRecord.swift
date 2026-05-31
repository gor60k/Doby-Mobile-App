import Foundation
import GRDB

struct UserRecord: Codable, FetchableRecord, PersistableRecord {
    let uuid: String //Внешний ключ
    
    var username: String
    var firstName: String?
    var lastName: String?
    var patronymic: String?
    
    var photos: [UserPhoto]?
    
    static let databaseTableName = "users"
}
