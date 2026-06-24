struct CreateChatInput: Codable {
    let participants: [String]
    let bookingId: Int?
}

extension CreateChatInput {
    static func direct(participants: [String]) -> Self {
        CreateChatInput(
            participants: participants,
            bookingId: nil
        )
    }
    
    static func fromBooking(participants: [String], bookingId: Int) -> Self {
        CreateChatInput(
            participants: participants,
            bookingId: bookingId
        )
    }
}
