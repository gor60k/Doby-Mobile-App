import Foundation

struct UserMock {
    static let owner = UserModel(
        id: UUID(),
        name: "Владелец питомца",
        role: .owner,
        phone: "+79999999999",
    )
    
    static let sitter = UserModel(
        id: UUID(),
        name: "Догситтер",
        role: .sitter,
        phone: "+79999999999"
    )
}
