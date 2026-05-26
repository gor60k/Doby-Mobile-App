import SwiftUI
import Kingfisher

struct ProfileQRAvatarView: View {
    let avatarURL: URL?
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.white.opacity(0.9))
                .frame(width: 118, height: 118)

            KFImage(avatarURL)
                .placeholder {
                    Circle()
                        .fill(Color.secondary.opacity(0.12))
                        .overlay {
                            Image(systemName: "person.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.secondary)
                        }
                }
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
        }
        .padding(.top, 20)
    }
}
