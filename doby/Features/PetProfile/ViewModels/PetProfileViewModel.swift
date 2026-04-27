import SwiftUI
import Observation

@Observable
final class PetProfileViewModel {
    var currentPage: Int = 0
    
    let slides: [PetAvaratSlide] = [
        PetAvaratSlide(id: 0, image: "PetAvatarPlaceholder"),
        PetAvaratSlide(id: 1, image: "PetAvatarPlaceholder"),
        PetAvaratSlide(id: 2, image: "PetAvatarPlaceholder"),
        PetAvaratSlide(id: 3, image: "PetAvatarPlaceholder"),
    ]
    
    let infoItems: [PetProfileInfoItem] = [
        .weight(6),
        .height(20),
        .color("Белый")
    ]
}
