import Foundation
import GRDB

struct ChatParticipantRecord: Codable, FetchableRecord, PersistableRecord {
    var chatId: Int64
    var userUUID: String
    
    static let databaseTableName = "chat_participants"
}
