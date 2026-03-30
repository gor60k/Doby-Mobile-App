import SwiftUI

struct ChatView: View {
    
    var body: some View {
        VStack {
            ViewHeadline(
                title: "Чат",
                subtitle: nil,
                titleStyle: AppTextStyle.Presets.largeTitleBold,
                subtitleStyle: nil
            )
        }
        .background(.primaryBackground)
    }
}

#Preview {
    ChatView()
}

