import Foundation
import GRDB

struct MessageRecord: Codable, FetchableRecord, PersistableRecord, Identifiable {
    let id: Int64
    
    let chatId: Int64 //Внешний ключ
    let senderUUID: String //Внешний ключ
    
    var text: String
    var originalFileName: String?
    
    var messageType: MessageType
    var isRead: Bool
    var dtCreated: Date
    
    var mediaURL: String?
    var isPinned: Bool = false
    
    static let databaseTableName = "messages"
}
