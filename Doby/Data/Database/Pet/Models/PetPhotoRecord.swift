import Foundation
import GRDB

struct PetPhotoRecord: Codable, Identifiable, FetchableRecord, PersistableRecord {
    static let databaseTableName: String = "pet_photos"
    static let databaseColumnDecodingStrategy: DatabaseColumnDecodingStrategy = .convertFromSnakeCase
    static let databaseColumnEncodingStrategy: DatabaseColumnEncodingStrategy = .convertToSnakeCase
    
    static let pet = belongsTo(PetRecord.self)
    
    let id: Int
    let petId: Int
    let imageURL: String
    let orderNumber: Int
    let isMain: Bool
}
