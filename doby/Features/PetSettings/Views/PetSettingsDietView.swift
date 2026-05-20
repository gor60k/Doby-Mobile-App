import SwiftUI

struct PetSettingsDietView: View {
    @Binding var dietType: String
    @Binding var dietPattern: String
    @Binding var dietAdditionalInfo: String
    
    var body: some View {
        Section("Питание") {
            TextField("Тип питания", text: $dietType)
                .textInputAutocapitalization(.sentences)

            TextField("Режим кормления", text: $dietPattern)
                .textInputAutocapitalization(.sentences)

            TextField(
                "Дополнительная информация о питании",
                text: $dietAdditionalInfo,
                axis: .vertical
            )
            .lineLimit(2...5)
        }
    }
}
