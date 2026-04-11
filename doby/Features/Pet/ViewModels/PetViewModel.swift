import SwiftUI
import Combine

final class PetViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    
    let slides: [PetAvaratSlide] = [
        PetAvaratSlide(id: 0, image: "PetAvatarPlaceholder"),
        PetAvaratSlide(id: 1, image: "PetAvatarPlaceholder"),
        PetAvaratSlide(id: 2, image: "PetAvatarPlaceholder"),
        PetAvaratSlide(id: 3, image: "PetAvatarPlaceholder"),
    ]
}
