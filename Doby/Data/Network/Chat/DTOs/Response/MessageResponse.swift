import Foundation

nonisolated
struct MessageResponse: Codable {
    let id: Int
    let sender_uuid: String
    let text: String
    let message_type: MessageTypeDTO
    let is_read: Bool
    let dt_created: Date
    let media_url: String?
}

