import SwiftUI
import PhotosUI

struct SettingsPhotosPickerView: View {
    @Binding var selectedAvatarItem: PhotosPickerItem?
    @Binding var selectedAvatarImage: UIImage?
    
    var body: some View {
        Section {
            VStack(spacing: 16) {
                PhotosPicker(selection: $selectedAvatarItem, matching: .images) {
                    VStack(spacing: 10) {
                        ZStack(alignment: .bottomTrailing) {
                            Group {
                                if let selectedAvatarImage {
                                    Image(uiImage: selectedAvatarImage)
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    Circle()
                                        .fill(Color.secondary.opacity(0.12))
                                        .overlay {
                                            Image(systemName: "person.fill")
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
                        
                        Text(selectedAvatarImage == nil ? "Загрузить аватар" : "Сменить аватар")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.accentColor)
                    }
                }
                .buttonStyle(.plain)
                
                VStack(spacing: 4) {
                    Text("Профиль")
                        .font(.headline)
                    Text("Управляйте личными данными и настройками аккаунта")
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
