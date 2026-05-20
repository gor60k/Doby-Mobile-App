import SwiftUI
import PhotosUI

struct PetAddingView: View {
    @Environment(PetRouter.self) private var router
    
    @State private var viewModel: PetAddingViewModel
    
    init(viewModel: PetAddingViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    private func addPet() {
        Task {
            await viewModel.addPet()
            
            if viewModel.errorMessage == nil {
                router.pop()
            }
        }
    }

    var body: some View {
        Form {
            PetAddingInfoView(
                petType: $viewModel.petType,
                petGender: $viewModel.petGender,
                name: $viewModel.name,
                breedName: $viewModel.breedName,
                age: $viewModel.age
            )
            
            PetAddingDetailsView(
                height: $viewModel.height,
                weight: $viewModel.weight,
                description: $viewModel.description
            )
            
            PetAddingNutritionView(
                feedingType: $viewModel.dietType,
                feedingSchedule: $viewModel.dietPattern,
                feedingNotes: $viewModel.dietAdditionalInfo
            )
            
            PetAddingPhotoView(
                selectedPhotoItems: $viewModel.selectedPhotoItems
            )
            
            PetAddingWarningView(
                warningTagsViewModel: $viewModel.warningTagsViewModel
            )
            
            PetAddingFeatureView(
                featureTagsViewModel: $viewModel.featureTagsViewModel
            )
        
            PetAddingSubmitView(
                addPet: {
                    addPet()
                },
                isLoading: viewModel.isLoading
            )
        }
    }
}

//#Preview {
//    PetAddingView(viewModel: <#T##PetAddingViewModel#>)
//        .PreviewAppEnvironment()
//        .environment(PetRouter())
//}
