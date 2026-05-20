import SwiftUI

struct PetSettingsView: View {
    @State private var viewMode: PetSettingsViewModel
    
    let petId: Int
    let ownerUUID: String
    
    @State var age: Int = 0
    
    @State var height: Int?
    @State var weight: Int?
    @State var description: String = ""
    
    init(
        viewModel: PetSettingsViewModel,
        petId: Int,
        ownerUUID: String
    ) {
        _viewMode = State(initialValue: viewModel)
        
        self.petId = petId
        self.ownerUUID = ownerUUID
    }
    
    var body: some View {
        Form {
            Section("Основые данные питомца") {
                Stepper("Возраст: \(age) лет", value: $age, in: 0...30)
            }
            
            PetSettingsDetailsView(
                height: $viewMode.height,
                weight: $viewMode.weight,
                description: $viewMode.description
            )
        }
        .task {
        }
    }
}
