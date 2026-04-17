import SwiftUI
import PhotosUI

struct PetAddingView: View {
    @State private var viewModel = PetAddingViewModel()

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
            
            submitSection
        }
    }

    @ViewBuilder
    private var submitSection: some View {
        Section {
            Button {
                Task {
                    await viewModel.addPet()
                }
            } label: {
                HStack {
                    Spacer()
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Добавить питомца")
                            .fontWeight(.semibold)
                    }
                    Spacer()
                }
            }
            .disabled(viewModel.isLoading || viewModel.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }

        if let errorMessage = viewModel.errorMessage {
            Section {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.footnote)
            }
        }
    }
}

#Preview {
    PetAddingView()
        .withAppEnvironment()
}
