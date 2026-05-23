import SwiftUI


//TODO: добавить изменение недостоющих полей в форме и изменение фотографий питомца
struct PetSettingsView: View {
    @State private var viewModel: PetSettingsViewModel
    
    let petId: Int
    let ownerUUID: String
    
    @State var age: Int = 0
    
    let openPetProfile: () -> Void
    
    init(
        viewModel: PetSettingsViewModel,
        petId: Int,
        ownerUUID: String,
        openPetProfile: @escaping () -> Void
    ) {
        _viewModel = State(initialValue: viewModel)
        
        self.petId = petId
        self.ownerUUID = ownerUUID
        self.openPetProfile = openPetProfile
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
                title: "Особенности"
            )
        }
        .navigationTitle(viewModel.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Готово") {
                    Task {
                        await viewModel.updatePet()
                        openPetProfile()
                    }
                }
            }
        }
    }
}

#Preview {
    PetSettingsView(
        viewModel: .mock,
        petId: 1,
        ownerUUID: "",
        openPetProfile: {}
    )
}
