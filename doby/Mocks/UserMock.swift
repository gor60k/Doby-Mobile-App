import Foundation

struct UserMock {
    static let owner = User(
        id: UUID(),
        name: "Владелец питомца",
        role: .owner,
        phone: "+79999999999",
    )
    
    static let sitter = User(
        id: UUID(),
        name: "Догситтер",
        role: .sitter,
        phone: "+79999999999"
    )
    
    static let users: [User] = [
        User(id: UUID(), name: "Джефри Эпштейн1", role: .owner, phone: "+79999999999", icon: "MockUserIcon"),
        User(id: UUID(), name: "Джефри Эпштейн2", role: .owner, phone: "+79999999999", icon: "MockUserIcon"),
        User(id: UUID(), name: "Джефри Эпштейн3", role: .owner, phone: "+79999999999", icon: "MockUserIcon"),
        User(id: UUID(), name: "Джефри Эпштейн4", role: .owner, phone: "+79999999999", icon: "MockUserIcon"),
        User(id: UUID(), name: "Джефри Эпштейн5", role: .owner, phone: "+79999999999", icon: "MockUserIcon"),
    ]
}
