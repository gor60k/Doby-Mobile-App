import SwiftUI
import PhotosUI

struct PetAddingView: View {
    @Environment(PetRouter.self) private var router
    
    @State private var viewModel: PetAddingViewModel
    
    init(repository: PetRepositoryProtocol) {
        _viewModel = State(initialValue: PetAddingViewModel(repository: repository))
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
                feedingType: $viewModel.feedingType,
                feedingSchedule: $viewModel.feedingSchedule,
                feedingNotes: $viewModel.feedingNotes
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
