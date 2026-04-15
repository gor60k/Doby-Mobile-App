import SwiftUI

struct PetDestinationView: View {
    let route: PetRoute
    
    var body: some View {
        switch route {
        case .profile(let id):
            PetProfileView(petId: id)
        }
    }
}
