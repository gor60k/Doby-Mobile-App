import SwiftUI

struct PetAddingInfoView: View {
    @Binding var petType: PetType?
    @Binding var petGender: Gender?
    @Binding var name: String
    @Binding var breedName: String
    @Binding var age: Int
    
    var body: some View {
        Section(
            header: PrimaryFormSectionHeader(title: "Основная информация", isRequired: true)
        ) {
            Picker("Тип питомца", selection: $petType) {
                Text("Собака").tag(PetType.dog)
                Text("Кошка").tag(PetType.cat)
            }
            .pickerStyle(.segmented)
            
            Picker("Пол питомца", selection: $petGender) {
                Text("Мальчик").tag(Gender.male)
                Text("Девочка").tag(Gender.female)
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

#Preview {
    PetAddingInfoView(
        petType: .constant(.dog),
        petGender: .constant(Gender.male),
        name: .constant(""),
        breedName: .constant(""),
        age: .constant(10)
    )
}
