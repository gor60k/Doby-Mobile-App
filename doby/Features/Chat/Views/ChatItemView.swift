import SwiftUI

struct ChatItemView: View {
    var body: some View {
        HStack(alignment: .top) {
            Image("MockUserIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            
            VStack {
                Text("Джефри Эпштейн")
                    .style(AppTextStyle.Presets.subheadlineSemibold)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .glassEffect(
            .regular.tint(.primaryYellowLight).interactive(),
            in: RoundedRectangle(cornerRadius: 16)
        )
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        VStack {
            ChatItemView()
        }
        .padding()
    }
}
