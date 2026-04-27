enum ProfileRoute: Hashable {
    case settings
    case settingsAppearance
    case settingsPrivacy
    case settingsNotifications
    case petSettings
    case petProfile(petId: Int)
    case petAdding
}
