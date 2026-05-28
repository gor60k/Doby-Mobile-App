import Observation

@Observable
final class SettingsPrivacyViewModel {
    var password: String = ""
    var newPassword: String = ""
    var confirmNewPassword: String = ""
}
