import Foundation
import GRDB

struct UserRecord: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName: String = "users"
    static let databaseColumnDecodingStrategy: DatabaseColumnDecodingStrategy = .convertFromSnakeCase
    static let databaseColumnEncodingStrategy: DatabaseColumnEncodingStrategy = .convertToSnakeCase
    
    static let photos = hasMany(UserPhotoRecord.self).order(Column("order_number"))
    static let pets = hasMany(PetRecord.self)
    static let city = belongsTo(CityRecord.self)
    
    let uuid: String
    var username: String
    var firstName: String?
    var lastName: String?
    var patronymic: String?
    var phone: String?
    var cityId: Int
    var bio: String?
}
