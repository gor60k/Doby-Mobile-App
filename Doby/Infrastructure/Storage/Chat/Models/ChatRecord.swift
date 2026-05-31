import Foundation
import GRDB

struct ChatRecord: Codable, FetchableRecord, PersistableRecord, Identifiable {
    let id: Int64 //Внешний ключ
    let booking: Int64
    
    let dtCreated: Date
    var isPinned: Bool = false
    
    static let databaseTableName = "chats"
}
