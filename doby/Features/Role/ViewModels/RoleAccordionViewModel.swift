import SwiftUI
import Combine

class RoleAccordionViewModel: ObservableObject {
    @Published var accordionItems: [RoleAccordionItem] = []
    @Published var selectedRole: String? = nil
    
    init() {
        setupItems()
    }
    
    private func setupItems() {
        self.accordionItems = [
            RoleAccordionItem(
                title: "Я Догситтер!",
                description: "Вы выбираете роль догситтера. Это значит, что владельцы питомцев смогут находить вас и доверять вам заботу о своих любимцах...",
                systemImage: "pet.carrier.fill",
                roleValue: "SITTER",
                bgColor: .primatyYellowLight
            ),
            RoleAccordionItem(
                title: "Я Владелец Питомца!",
                description: "Вы выбираете роль владельца питомца. Это позволит вам находить проверенных догситтеров...",
                systemImage: "dog.fill",
                roleValue: "OWNER",
                bgColor: .primatyYellowLight
            )
        ]
    }
    
    func selectRole(_ role: String) {
        selectedRole = role
        UserDefaults.standard.set(role, forKey: "selectedUserRole")
    }
}
