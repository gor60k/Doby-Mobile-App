import SwiftUI

struct PetAddingNutritionView: View {
    @Binding var feedingType: String
    @Binding var feedingSchedule: String
    @Binding var feedingNotes: String
    
    var body: some View {
        Section("Питание") {
            TextField("Тип питания", text: $feedingType)
                .textInputAutocapitalization(.sentences)

            TextField("Режим кормления", text: $feedingSchedule)
                .textInputAutocapitalization(.sentences)

            TextField(
                "Дополнительная информация о питании",
                text: $feedingNotes,
                axis: .vertical
            )
            .lineLimit(2...5)
        }
    }
}
