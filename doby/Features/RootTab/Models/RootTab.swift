enum RootTab: String, CaseIterable {
    // MARK: - Табы владельца питомца
    case search
    case pet
    
    // MARK: - Табы догситтера
    case orders
    case calendar
    case earnings
    
    // MARK: - Общие табы
    case chat
    case profile
 
    var icon: String {
        switch self {
        // MARK: - Иконки владельца питомца
        case .search: return "magnifyingglass"
        case .pet: return "dog.fill"
        // MARK: - Иконки догситтера
        case .orders: return "list.bullet.clipboard"
        case .calendar: return "calendar"
        case .earnings: return "banknote.fill"
        // MARK: - Общие иконки
        case .chat: return "bubble.left.and.bubble.right.fill"
        case .profile: return "person.fill"
        }
    }
    
    var title: String {
        switch self {
        // MARK: - Тайтлы владельца питомца
        case .search: return "Поиск"
        case .pet: return "Профиль"
        // MARK: - Тайтлы догситтера
        case .orders: return "Заказы"
        case .calendar: return "Календарь"
        case .earnings: return "Доходы"
        // MARK: - Общие тайтлы
        case .chat: return "Чат"
        case .profile: return "Профиль"
        }
    }
}
