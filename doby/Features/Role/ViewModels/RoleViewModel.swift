import SwiftUI
import Combine

class RoleViewModel: ObservableObject {
    @Published var accordionItems: [RoleDisclosureItem] = []
    @Published var selectedRole: Role? = nil
    
    private let storageKey = "selectedUserRole"
    
    init() {
        loadSelectedRole()
        setupItems()
    }
    
    private func loadSelectedRole() {
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let savedRole = try? JSONDecoder().decode(Role.self, from: data)
        else { return }
        
        selectedRole = savedRole
    }
    
    private func setupItems() {
        accordionItems = [
            RoleDisclosureItem(
                title: "Я Догситтер!",
                description: "Вы выбираете роль догситтера. Это значит, что владельцы питомцев смогут находить вас и доверять вам заботу о своих любимцах...",
                systemImage: "pet.carrier.fill",
                role: .sitter
            ),
            RoleDisclosureItem(
                title: "Я Владелец Питомца!",
                description: "Вы выбираете роль владельца питомца. Это позволит вам находить проверенных догситтеров...",
                systemImage: "dog.fill",
                role: .owner
            )
        ]
    }
    
    func selectRole(_ role: Role) {
        selectedRole = role
        
        guard let data = try? JSONEncoder().encode(role) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}
