import SwiftUI
import Combine

final class SettingsViewModel: ObservableObject {
    private var session = SessionService.shared
    
    @Published var username: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var city: City = City(name: "Novorossiysk", translit: "novorossiysk")
    
    @Published var password: String = ""
    @Published var newPassword: String = ""
    @Published var confirmNewPassword: String = ""
    
    @Published var phone: String = ""
    @Published var email: String = ""
    
    init() {
        loadCurrentUser()
    }
    
    func loadCurrentUser() {
        guard let user = session.currentUser else { return }
        
        username = user.username
        name = user.firstName ?? ""
        surname = user.lastName ?? ""
        phone = user.phone ?? ""
        email = user.username
    }
}
