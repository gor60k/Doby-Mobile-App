import SwiftUI

struct PrimaryTextField<Content: View>: View {
   
    private let title: String
    private let content: Content
    private let isValid: Bool
    private let showsError: Bool
    private let errorText: String?
    
    init(
        title: String,
        isValid: Bool = true,
        showsError: Bool = false,
        errorText: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.isValid = isValid
        self.showsError = showsError
        self.errorText = errorText
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            PrimaryText(
                text: title,
                style: .secondaryContent
            )
            
            content
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(showsError && !isValid ? Color(.red) : .secondary, lineWidth: 1)
                )
            
            if let errorText, showsError && !isValid {
                PrimaryText(
                    text: errorText,
                    style: .destructiveAction
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ZStack {
        PrimaryTextField(title: "Text") {
            TextField("Text", text: .constant(""))
        }
        .padding()
    }
}
