import SwiftUI

struct PetAddingInfoView: View {
    @Binding var petType: PetType
    @Binding var name: String
    @Binding var breedName: String
    @Binding var age: Int
    
    var body: some View {
        Section("Основная информация") {
            Picker("Тип питомца", selection: $petType) {
                Text("Собака").tag(PetType.dog)
                Text("Кошка").tag(PetType.cat)
            }
            .pickerStyle(.segmented)

            TextField("Имя питомца", text: $name)
                .textInputAutocapitalization(.words)

            TextField("Порода", text: $breedName)
                .textInputAutocapitalization(.words)

            Stepper("Возраст: \(age) лет", value: $age, in: 0...30)
        }
    }
}
