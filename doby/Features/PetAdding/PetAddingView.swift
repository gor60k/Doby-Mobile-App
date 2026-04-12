import SwiftUI

struct PetAddingView: View {
    @State private var viewModel = PetAddingViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Add a new pet")) {
                TextField("Имя", text: $viewModel.name)
                
                Stepper("Возраст: \(viewModel.age)", value: $viewModel.age, in: 0...30)
                
                HStack {
                    Text("Высота")
                    Spacer()
                    TextField("см", value: $viewModel.height, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                
                HStack {
                    Text("Вес")
                    Spacer()
                    TextField("кг", value: $viewModel.weight, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                
                TextField("Порода", text: $viewModel.breedName)
                
                Button(action: {
                    Task {
                        await viewModel.addPet()
                    }
                }) {
                    Text("Добавить питомца")
                }
            }
        }
    }
}

#Preview {
    PetAddingView()
        .withAppEnvironment()
}
