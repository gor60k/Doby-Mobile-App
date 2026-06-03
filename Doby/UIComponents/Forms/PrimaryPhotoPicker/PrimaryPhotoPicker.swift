import SwiftUI
import PhotosUI
import Kingfisher

struct PrimaryPhotoPicker: View {
    
    @Binding var selectedPhotoItem: PhotosPickerItem?
    @Binding var selectedPhotoImage: UIImage?
    
    let currentPhotoURL: URL?
    let placeholderIcon: String
    
    let title: String
    let subtitle: String
    
    private var hasPhoto: Bool {
        selectedPhotoImage != nil
    }
    
    var body: some View {
        Section {
            VStack(spacing: 16) {
                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    VStack(spacing: 10) {
                        ZStack(alignment: .bottomTrailing) {
                            PrimaryPhotoPickerAvatar(
                                selectedPhotoImage: selectedPhotoImage,
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
