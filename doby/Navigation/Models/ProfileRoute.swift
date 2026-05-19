enum ProfileRoute: Hashable {
    case settings
    case settingsAppearance
    case settingsPrivacy
    case settingsNotifications
    case petAdding
    case petProfile(id: Int)
    case petSettings(id: Int)
    
}
