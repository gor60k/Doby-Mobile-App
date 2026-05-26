enum DisplayMode {
    case owner
    case visitor
    
    var isOwner: Bool {
        self == .owner
    }
}
