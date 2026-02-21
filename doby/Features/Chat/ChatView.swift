import SwiftUI

struct ChatView: View {
    
    var body: some View {
        VStack {
            HeaderView(title: "Чат", subtitle: "Общайтесь", titleStyle: AppTextStyle.Presets.largeTitleBold, subtitleStyle: AppTextStyle.Presets.subheadlineMedium)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<5, id: \.self) { _ in
                        ChatItemView()
                    }
                }
                .padding()
            }
        }
    }
}

