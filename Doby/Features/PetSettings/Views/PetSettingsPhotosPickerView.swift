import SwiftUI
import PhotosUI
import Kingfisher

struct PetSettingsPhotosPickerView: View {
    
    @Binding var selectedPhotoItem: PhotosPickerItem?
    @Binding var selectedPhotoImage: UIImage?
    let currentPhotoURL: URL?
    
    var body: some View {
        Section {
            VStack(spacing: 16) {
                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    VStack(spacing: 10) {
                        ZStack(alignment: .bottomTrailing) {
                            Group {
                                if let selectedPhotoImage {
                                    Image(uiImage: selectedPhotoImage)
                                        .resizable()
                                        .scaledToFill()
                                } else if let currentPhotoURL {
                                    KFImage(currentPhotoURL)
                                        .placeholder {
                                            ProgressView()
                                        }
                                        .cancelOnDisappear(true)
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    Circle()
                                        .fill(Color.secondary.opacity(0.12))
                                        .overlay {
                                            Image(systemName: "pawprint.fill")
                                                .font(.system(size: 36))
                                                .foregroundColor(.secondary)
                                        }
                                }
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            
                            ZStack {
                                Circle()
                                    .fill(Color.accentColor)
                                    .frame(width: 28, height: 28)
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Text(selectedPhotoImage == nil ? "Загрузить фото" : "Добавить фото")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.accentColor)
                    }
                }
                .buttonStyle(.plain)
                
                VStack(spacing: 4) {
                    Text("Профиль питомца")
                        .font(.headline)
                    Text("Управляйте данными вашего питомца")
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
