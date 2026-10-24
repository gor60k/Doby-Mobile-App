import SwiftUI
import PhotosUI

//TODO: добавить изменение недостоющих полей в форме и изменение фотографий питомца
struct PetSettingsScreen: View {
    @State private var viewModel: PetSettingsViewModel
    @State private var selectedPhotoItem: PhotosPickerItem?
    
    let petId: Int
    let ownerUUID: String
    
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
            PrimaryPhotoPicker(
                viewModel: viewModel.photoPickerViewModel,
                currentPhotoURL: viewModel.currentPhotoURL,
                onImageReady: { data in
                    await viewModel.uploadPhoto(data)
                },
                
                placeholderIcon: "pawprint.fill",
                title: "Профиль питомца",
                subtitle: "Управляйте данными вашего питомца"
            )
            
            PetSettingsDetailsView(
                height: $viewModel.form.height,
                weight: $viewModel.form.weight,
                description: $viewModel.form.description
            )
            
            PetSettingsDietView(
                dietType: $viewModel.form.dietType,
                dietPattern: $viewModel.form.dietPatterns,
                dietAdditionalInfo: $viewModel.form.dietAdditionalInfo
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
        .navigationTitle(viewModel.pet?.name ?? "")
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
        .task {
            await viewModel.loadPet()
        }
    }
}

//#Preview {
//    PetSettingsScreen(
//        viewModel: .mock,
//        petId: 1,
//        ownerUUID: "",
//        openPetProfile: {}
//    )
//    .PreviewAppEnvironment()
//}
