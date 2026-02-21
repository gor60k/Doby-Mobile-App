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
    
    static let users: [UserModel] = [
        UserModel(id: UUID(), name: "Джефри Эпштейн1", role: .owner, phone: "+79999999999", icon: "MockUserIcon"),
        UserModel(id: UUID(), name: "Джефри Эпштейн2", role: .owner, phone: "+79999999999", icon: "MockUserIcon"),
        UserModel(id: UUID(), name: "Джефри Эпштейн3", role: .owner, phone: "+79999999999", icon: "MockUserIcon"),
        UserModel(id: UUID(), name: "Джефри Эпштейн4", role: .owner, phone: "+79999999999", icon: "MockUserIcon"),
        UserModel(id: UUID(), name: "Джефри Эпштейн5", role: .owner, phone: "+79999999999", icon: "MockUserIcon"),
    ]
}
