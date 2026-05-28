import Foundation

struct ChatDTO: Codable {
    let id: Int
    let booking: Int
    let participants: [UserDTO]
    let messages: [MessageDTO]
    let dt_created: Date
}
