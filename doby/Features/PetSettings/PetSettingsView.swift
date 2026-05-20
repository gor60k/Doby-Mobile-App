import SwiftUI

struct PetSettingsView: View {
    @State private var viewModel: PetSettingsViewModel
    
    let petId: Int
    let ownerUUID: String
    
    @State var age: Int = 0
    
    init(
        viewModel: PetSettingsViewModel,
        petId: Int,
        ownerUUID: String
    ) {
        _viewModel = State(initialValue: viewModel)
        
        self.petId = petId
        self.ownerUUID = ownerUUID
    }
    
    var body: some View {
        Form {
            Section("Основые данные питомца") {
                Stepper("Возраст: \(age) лет", value: $age, in: 0...30)
            }
            
            PetSettingsDetailsView(
                height: $viewModel.height,
                weight: $viewModel.weight,
                description: $viewModel.description
            )
            
            PetSettingsDietView(
                dietType: $viewModel.dietType,
                dietPattern: $viewModel.dietPattern,
                dietAdditionalInfo: $viewModel.dietAdditionalInfo
            )
            
            PetSettingsTagsView(
                viewModel: $viewModel.warningTagsViewModel,
                title: "Особые предупреждения"
            )
            
            PetSettingsTagsView(
                viewModel: $viewModel.featureTagsViewModel,
                title: "Особенности")
        }
    }
}

#Preview {
    PetSettingsView(
        viewModel: .mock,
        petId: 1,
        ownerUUID: ""
    )
}
