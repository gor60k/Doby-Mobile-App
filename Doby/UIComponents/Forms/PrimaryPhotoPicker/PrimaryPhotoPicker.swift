import SwiftUI
import Kingfisher
import PhotosUI

struct PrimaryPhotoPicker: View {
    
    @State private var selectedPhotoItem: PhotosPickerItem?

    let viewModel: PrimaryPhotoPickerViewModel
    let currentPhotoURL: URL?
    let onImageReady: (Data) async -> Void
    
    let placeholderIcon: String
    let title: String
    let subtitle: String
    
    private var hasPhoto: Bool {
        viewModel.selectedPhotoImage != nil
    }
    
    var body: some View {
        Section {
            VStack(spacing: 16) {
                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    VStack(spacing: 10) {
                        ZStack(alignment: .bottomTrailing) {
                            PrimaryPhotoPickerAvatar(
                                selectedPhotoImage: viewModel.selectedPhotoImage,
                                currentPhotoURL: currentPhotoURL,
                                placeholderIcon: placeholderIcon
                            )

                            PrimaryPhotoPickerCameraBadge()
                        }

                        Text(hasPhoto ? "Добавить фото" : "Загрузить фото")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.accentColor)
                    }
                }
                .buttonStyle(.plain)
                .task(id: selectedPhotoItem) {
                    guard let selectedPhotoItem else { return }

                    guard let data = await viewModel.processPhoto(selectedPhotoItem) else {
                        return
                    }

                    await onImageReady(data)
                }
                
                VStack(spacing: 4) {
                    Text(title)
                        .font(.headline)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        }
    }
}
