import SwiftUI

struct ChatView: View {
    
    var body: some View {
        VStack {
            ViewHeadline(title: "Чат", subtitle: nil, titleStyle: AppTextStyle.Presets.largeTitleBold, subtitleStyle: nil)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(UserMock.users) { user in
                        ChatItemView(userName: user.name, userIcon: user.icon ?? "")
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ChatView()
}

