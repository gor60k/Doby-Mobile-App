import SwiftUI

struct PrimaryTextField<Content: View>: View {
   
    private let title: String
    private let content: Content
    
    init(
        title: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack {
            Text(title)
                .style(AppTextStyle.Presets.headlineRegular)
                .frame(maxWidth: .infinity, alignment: .leading)
            
           content
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.primaryYellow, lineWidth: 1)
                )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        PrimaryTextField(title: "Text") {
            TextField("Text", text: .constant(""))
        }
        .padding()
    }
}
