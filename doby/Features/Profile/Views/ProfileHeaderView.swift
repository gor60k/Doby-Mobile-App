import SwiftUI

struct ProfileHeaderView: View {
    @State var user: User?
    
    var body: some View {
        VStack {
            let fullName = "\(user?.firstName ?? "") \(user?.lastName ?? "")"
            
//            Image(systemName: "person.circle.fill")
//                .resizable()
//                .scaledToFill()
//                .frame(width: 100, height: 100)
//                .foregroundColor(Color(.secondarySystemBackground))
            Circle()
                .fill(Color.secondary.opacity(0.12))
                .overlay {
                    Image(systemName: "person.fill")
                        .font(.system(size: 36))
                        .foregroundColor(.secondary)
                }
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
            
            Text("42 года, Краснодар, Юбилейный")
                .style(AppTextStyle.Presets.headlineRegular)
        }
    }
}

#Preview {
    ProfileHeaderView()
}
