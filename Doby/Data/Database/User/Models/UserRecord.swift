import Foundation
import GRDB

struct UserRecord: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName: String = "users"
    static let databaseColumnDecodingStrategy: DatabaseColumnDecodingStrategy = .convertFromSnakeCase
    static let databaseColumnEncodingStrategy: DatabaseColumnEncodingStrategy = .convertToSnakeCase
    
    static let photos = hasMany(UserPhotoRecord.self, using: ForeignKey(["user_uuid"])).order(Column("order_number"))
    static let pets = hasMany(PetRecord.self, using: ForeignKey(["owner_uuid"]))
    static let city = belongsTo(CityRecord.self, using: ForeignKey(["city_id"]))
    
    let uuid: String
    var username: String
    var firstName: String?
    var lastName: String?
    var patronymic: String?
    var phone: String?
    var cityId: Int
    var bio: String?
}
