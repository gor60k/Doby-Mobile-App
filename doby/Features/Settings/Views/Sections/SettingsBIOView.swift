import SwiftUI

struct SettingsBIOView: View {
    @Binding var bio: String
    
    var body: some View {
        Section("О себе") {
            ZStack(alignment: .leading) {
                if bio.isEmpty {
                    Text("Расскажите о себе")
                        .foregroundColor(Color(.secondaryLabel).opacity(0.5))
                        .padding(.leading, 5)
                }
                TextEditor(text: $bio)
                    .frame(maxWidth: .infinity)
            }
            
        }
    }
}
