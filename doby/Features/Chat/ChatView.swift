import SwiftUI

struct ChatView: View {
    
    var body: some View {
        VStack {
            HeaderView(title: "Чат", subtitle: "Общайтесь", titleStyle: AppTextStyle.Presets.largeTitleBold, subtitleStyle: AppTextStyle.Presets.subheadlineMedium)
            
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

