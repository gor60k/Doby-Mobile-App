import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    let uuid: String?
    let photo: Photo?
    let username: String?
    let firstName: String?
    let lastName: String?
    let cityName: String?
    
    let showPhotoGallery: () -> Void
    
    private let baseURL: URL = APIConstants.getImageBaseURL()
    
    private var imageURL: URL? {
        guard let photo else { return nil }
        return baseURL.appendingPathComponent(photo.imageURL)
    }
    
    private var fullName: String {
        if let firstName, !firstName.isEmpty {
            if let lastName, !lastName.isEmpty {
                return "\(firstName) \(lastName)"
            }
            return firstName
        }
        
        if let username, !username.isEmpty {
            return username
        }
        
        return "Хвостик-\(uuid ?? "unknown")"
    }
    
    private var subtitle: String {
        return "42 года, \(cityName ?? "город не указан")"
    }
    
    var body: some View {
        VStack {
            Button(action: showPhotoGallery) {
                KFImage(imageURL)
                    .placeholder {
                        PrimaryAvatarPlaceholder(icon: "person.fill")
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .unredacted()
            }
            
            Text(fullName)
                .style(AppTextStyle.Presets.titleSemibold)
            
            Text(subtitle)
                .style(AppTextStyle.Presets.headlineRegular)
        }
    }
}

#Preview {
    NavigationStack {
        VStack {
            ProfileHeaderView(
                uuid: "228",
                photo: Photo(
                    id: 1,
                    imageURL: "",
                    orderNumber: 1,
                    isMain: true
                ),
                username: "Username username",
                firstName: "",
                lastName: "",
                cityName: "",
                showPhotoGallery: {}
            )
            
            Spacer()
        }
    }
    .navigationTitle("Профиль")
    .toolbar {
        ToolbarItem(placement: .topBarLeading) {
            Button("Кнопка", systemImage: "pen") {}
        }
    }
}
