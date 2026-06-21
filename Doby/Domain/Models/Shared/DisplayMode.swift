enum DisplayMode: Equatable {
    case owner
    case visitor
    
    var isOwner: Bool {
        self == .owner
    }
}
