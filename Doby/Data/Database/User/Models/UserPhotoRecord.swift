import Foundation
import GRDB

struct UserPhotoRecord: Codable, Identifiable, FetchableRecord, PersistableRecord {
    static let databaseTableName: String = "user_photos"
    static let databaseColumnDecodingStrategy: DatabaseColumnDecodingStrategy = .convertFromSnakeCase
    static let databaseColumnEncodingStrategy: DatabaseColumnEncodingStrategy = .convertToSnakeCase
    
    static let user = belongsTo(UserRecord.self)
    
    let id: Int
    let userUuid: String
    let imageUrl: String
    let orderNumber: Int
    let isMain: Bool
}
