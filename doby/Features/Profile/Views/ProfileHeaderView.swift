import SwiftUI

struct ProfileHeaderView: View {
    let uuid: String?
    let username: String?
    let firstName: String?
    let lastName: String?
    
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
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.secondary.opacity(0.12))
                .overlay {
                    Image(systemName: "person.fill")
                        .font(.system(size: 36))
                        .foregroundColor(.secondary)
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            Text(fullName)
                .style(AppTextStyle.Presets.titleSemibold)
            
            Text("42 года, Краснодар, Юбилейный")
                .style(AppTextStyle.Presets.headlineRegular)
        }
    }
}

#Preview {
    ProfileHeaderView(
        uuid: "228",
        username: "",
        firstName: "",
        lastName: ""
    )
}
