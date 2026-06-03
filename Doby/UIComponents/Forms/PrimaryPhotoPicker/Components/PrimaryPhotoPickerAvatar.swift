import SwiftUI
import PhotosUI
import Kingfisher

struct PrimaryPhotoPickerAvatar: View {

    let selectedPhotoImage: UIImage?
    let currentPhotoURL: URL?
    let placeholderIcon: String

    var body: some View {
        Group {
            if let selectedPhotoImage {
                Image(uiImage: selectedPhotoImage)
                    .resizable()
                    .scaledToFill()
            } else if let currentPhotoURL {
                KFImage(currentPhotoURL)
                    .placeholder {
                        PrimaryAvatarPlaceholder(icon: placeholderIcon)
                    }
                    .cancelOnDisappear(true)
                    .resizable()
                    .scaledToFill()
            } else {
                PrimaryAvatarPlaceholder(icon: placeholderIcon)
            }
        }
        .frame(width: 100, height: 100)
        .clipShape(Circle())
        .onAppear {
            print("!!!selectedPhotoImage:", selectedPhotoImage != nil)
            print("!!!currentPhotoURL:", currentPhotoURL as Any)
        }
    }
}
