import SwiftUI

struct ProfileHeaderView: View {
    @State var user: User?
    
    var body: some View {
        VStack {
            let fullName = "\(user?.firstName) \(user?.lastName)"
            
            Image("ProfileAvatarPlaceholder")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            if let firstName = user?.firstName, !firstName.isEmpty {
                HStack {
                    Text(fullName)
                        .style(AppTextStyle.Presets.titleSemibold)
                }
            } else if let username = user?.username, !username.isEmpty {
                Text(username)
                    .style(AppTextStyle.Presets.titleSemibold)
            } else {
                Text("Хвостик-\(user?.uuid)")
                    .style(AppTextStyle.Presets.titleSemibold)
            }
        }
    }
}
