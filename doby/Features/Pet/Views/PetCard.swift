import SwiftUI
import Kingfisher

struct PetCard: View {
    @Environment(PetRouter.self) private var router
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    let id: Int
    let imageURL: String?
    let name: String
    let breedName: String
    let age: Int
    
    private let baseURL = APIConstants.baseURL
    
    private var fullImageURL: URL? {
        guard let imageURL else { return nil}
        
        return URL(string: baseURL.absoluteString)?.appendingPathComponent(imageURL)
    }
    
    var body: some View {
        Button(action: {
            router.push(.profile(id: id))
        }) {
            HStack(spacing: 12) {
                KFImage(fullImageURL)
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.headline)
                    
                    Text("Порода: \(breedName)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(age.yearsString)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.primary.opacity(0.06), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
