nonisolated
struct CreateChatRequest: Codable {
    let participants: [String]
    let booking_id: Int?
}
