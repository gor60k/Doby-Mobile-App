import Foundation

nonisolated
struct ChatPayload: Codable {
    let chat: ChatRecord
    let participants: [UserRecord]
    let messages: [MessageRecord]
}
