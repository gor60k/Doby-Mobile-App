import Foundation
import GRDB

struct Chat: Codable, FetchableRecord, PersistableRecord, Identifiable {
    let id: Int64
    let booking: Int64
    
    let dtCreated: Date
    var isPinned: Bool = false
    
    static let databaseTableName = "chats"
}
