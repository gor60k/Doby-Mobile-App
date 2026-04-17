import SwiftUI

struct PetAddingDetailsView: View {
    @Binding var height: Int
    @Binding var weight: Int
    @Binding var description: String
    
    var body: some View {
        Section("Параметры и описание") {
            HStack {
                Text("Высота")
                Spacer()
                TextField("см", value: $height, format: .number)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }

            HStack {
                Text("Вес")
                Spacer()
                TextField("кг", value: $weight, format: .number)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Описание")
                TextField(
                    "Например: любит долгие прогулки, спокойно ездит в машине, не любит шум...",
                    text: $description,
                    axis: .vertical
                )
                .lineLimit(4...8)
            }
        }
    }
}
