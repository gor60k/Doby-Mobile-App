import Foundation
import GRDB

struct CityRecord: Codable, FetchableRecord, PersistableRecord {
    static let databaseTableName: String = "cities"
    static let databaseColumnEncodingStrategy: DatabaseColumnEncodingStrategy = .convertToSnakeCase
    static let databaseColumnDecodingStrategy: DatabaseColumnDecodingStrategy = .convertFromSnakeCase
    
    var id: Int
    var name: String
    var translit: String
}
