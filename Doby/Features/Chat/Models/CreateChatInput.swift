struct CreateChatInput: Codable {
    let participants: [String]
    let bookingId: Int?
}
