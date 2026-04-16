import SwiftUI
import PhotosUI
import _PhotosUI_SwiftUI

struct PetAddingPhotoView: View {
    @Binding var selectedPhotoItems: [PhotosPickerItem]
    
    var body: some View {
        Section("Фотографии") {
            PhotosPicker(
                selection: $selectedPhotoItems,
                maxSelectionCount: 10,
                matching: .images
            ) {
                Label("Добавить фото", systemImage: "photo.on.rectangle.angled")
            }

            if !selectedPhotoItems.isEmpty {
                Text("Выбрано фото: \(selectedPhotoItems.count)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
