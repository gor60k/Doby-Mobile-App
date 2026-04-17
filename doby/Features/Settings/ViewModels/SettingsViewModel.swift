import SwiftUI
import Observation

@Observable
final class SettingsViewModel {
    private var session = SessionService.shared
    private var userStorage = UserStorage.shared
    
    var username: String = ""
    var name: String = ""
    var surname: String = ""
    var city: City = City(name: "Novorossiysk", translit: "novorossiysk")
    
    var password: String = ""
    var newPassword: String = ""
    var confirmNewPassword: String = ""
    
    var phone: String = ""
    var email: String = ""
    
    init() {
        loadCurrentUser()
    }
    
    func loadCurrentUser() {
        guard let user = userStorage.currentUser else { return }
        
        username = user.username
        name = user.firstName ?? ""
        surname = user.lastName ?? ""
        phone = user.phone ?? ""
        email = user.username
    }
}
