import SwiftUI
import Combine

final class PetProfileViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    
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
    
    let pet: Pet = Pet(
        id: 0,
        petType: .dog,
        name: "Бобик",
        age: 2,
        ownerUUID: UUID(uuidString: "123E4567-E89B-12D3-A456-426614174000")!,
        height: 0,
        weight: 0,
        breedName: ""
    )
}
