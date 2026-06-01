nonisolated
struct MessageRequest: Codable {
    let chat: Int
    let text: String
    let media_file: String?
}
