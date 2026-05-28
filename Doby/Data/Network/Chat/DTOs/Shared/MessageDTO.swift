import Foundation

struct MessageDTO: Codable {
    let id: Int
    let sender_uuid: String
    let text: String
    let original_filename: String
    let message_type: MessageTypeDTO
    let is_read: Bool
    let dt_created: Date
    let media_url: String
}
