import SwiftUI

struct PetSettingsDetailsView: View {
    @Binding var height: Int?
    @Binding var weight: Int?
    @Binding var description: String
    
    var body: some View {
        Section("Параметры и описание") {
            HStack {
                Text("Рост")
                Spacer()
                TextField("см", text: $height.stringValue)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
            HStack {
                Text("Вес")
                Spacer()
                TextField("кг", text: $weight.stringValue)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Описание")
                TextField(
                    "Опишите своего питомца, напрмер: характер, любимые и нелюбимые люди, и т.д.",
                    text: $description,
                    axis: .vertical
                )
                .lineLimit(4...8)
            }
        }
    }
}

#Preview {
    Form {
        PetSettingsDetailsView(
            height: .constant(100),
            weight: .constant(100),
            description: .constant("Пенисы")
        )
    }
}
