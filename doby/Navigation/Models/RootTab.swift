enum RootTab: Hashable {
    case pet
    case orders
    case chat
    case profile
 
    var icon: String {
        switch self {
        case .pet: return "dog.fill"
        case .orders: return "list.bullet.clipboard"
        case .chat: return "bubble.left.and.bubble.right.fill"
        case .profile: return "person.fill"
        }
    }
    
    var title: String {
        switch self {
        case .pet: return "Питомцы"
        case .orders: return "Заказы"
        case .chat: return "Чат"
        case .profile: return "Профиль"
        }
    }
}
