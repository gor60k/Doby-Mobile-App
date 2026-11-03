import Foundation
import GRDB

struct PetRecord: Codable, Identifiable, FetchableRecord, PersistableRecord {
    static let databaseTableName = "pets"
    static let databaseColumnEncodingStrategy: DatabaseColumnEncodingStrategy = .convertToSnakeCase
    static let databaseColumnDecodingStrategy: DatabaseColumnDecodingStrategy = .convertFromSnakeCase
    
    
    static let photos = hasMany(PetPhotoRecord.self).order(Column("order_number"))
    static let owner = belongsTo(UserRecord.self, using: ForeignKey(["owner_uuid"]))
    
    let id: Int
    let petType: PetType
    let ownerUuid: String
    let name: String
    let age: Int
    let gender: PetGender
    let height: Int
    let weight: Int
    let breedName: String
    let dietType: String
    let dietPatterns: String
    let warningTags: [String]
    let specificTags: [String]
    let additionalInfo: String
    let dietAdditionalInfo: String
}

extension PetRecord {
    static func replaceAll(
        _ items: [PetSnapshot],
        ownerUuid: String,
        in db: Database
    ) throws {
        let ids = items.map(\.pet.id)

        try PetRecord
            .filter(Column("owner_uuid") == ownerUuid)
            .filter(!ids.contains(Column("id")))
            .deleteAll(db)

        for item in items {
            try item.pet.save(db)
            try PetPhotoRecord.filter(Column("pet_id") == item.pet.id).deleteAll(db)
            for photo in item.photos { try photo.insert(db) }
        }
    }
}
