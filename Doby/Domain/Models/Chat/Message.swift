import Foundation
import GRDB

struct Message: Codable, FetchableRecord, PersistableRecord, Identifiable {
    let id: Int64
    
    let senderUUID: String
    let text: String
    let originalFileName: String
    
    let messageType: MessageType
    let isRead: Bool
    let dtCreated: Date
    
    let mediaURL: String
    var isPinned: Bool = false
    
    static let databaseTableName = "messages"
}
