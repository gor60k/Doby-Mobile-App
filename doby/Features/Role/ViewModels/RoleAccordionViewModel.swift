import SwiftUI
import Combine

class RoleAccordionViewModel: ObservableObject {
    @Published var accordionItems: [RoleAccordionItem] = []
    @Published var selectedRole: Role? = nil
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "selectedUserRole"),
           let savedRole = try? JSONDecoder().decode(Role.self, from: data) {
            self.selectedRole = savedRole
        }
        setupItems()
    }
    
    private func setupItems() {
        self.accordionItems = [
            RoleAccordionItem(
                title: "Я Догситтер!",
                description: "Вы выбираете роль догситтера. Это значит, что владельцы питомцев смогут находить вас и доверять вам заботу о своих любимцах...",
                systemImage: "pet.carrier.fill",
                roleValue: .sitter,
                bgColor: .primaryYellowLight
            ),
            RoleAccordionItem(
                title: "Я Владелец Питомца!",
                description: "Вы выбираете роль владельца питомца. Это позволит вам находить проверенных догситтеров...",
                systemImage: "dog.fill",
                roleValue: .owner,
                bgColor: .primaryYellowLight
            )
        ]
    }
    
    func selectRole(_ role: Role) {
        selectedRole = role
        if let data = try? JSONEncoder().encode(role) {
            UserDefaults.standard.set(data, forKey: "selectedUserRole")
        }
    }
}
