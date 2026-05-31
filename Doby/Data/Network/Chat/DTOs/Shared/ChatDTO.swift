import Foundation

nonisolated
struct ChatDTO: Codable {
    let id: Int64
    let booking: Int64
    let participants: [UserDTO]
    let messages: [MessageDTO]
    let dt_created: Date
}
