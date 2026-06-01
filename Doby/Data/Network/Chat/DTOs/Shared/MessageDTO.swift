import Foundation

nonisolated
struct MessageDTO: Codable {
    let id: Int64
    let sender_uuid: String
    let text: String
    let original_filename: String
    let message_type: MessageTypeDTO
    let is_read: Bool
    let dt_created: Date
    let media_url: String
}
