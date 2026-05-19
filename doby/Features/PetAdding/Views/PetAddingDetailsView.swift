import SwiftUI

struct PetAddingDetailsView: View {
    @Binding var height: Int?
    @Binding var weight: Int?
    @Binding var description: String
    
    var body: some View {
        Section("Параметры и описание") {
            HStack {
                PrimaryFormSectionHeader(title: "Высота", isRequired: true)
                Spacer()
                TextField("см", text: $height.stringValue)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }

            HStack {
                PrimaryFormSectionHeader(title: "Вес", isRequired: true)
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

extension Binding where Value == Int? {
    var stringValue: Binding<String> {
        Binding<String>(
            get: { wrappedValue.map(String.init) ?? "" },
            set: { wrappedValue = Int($0) }
        )
    }
}
