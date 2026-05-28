import SwiftUI

struct PrimaryPicker<Option: Hashable>: View {
    @Binding var selection: Option
    let options: [Option]
    let title: (Option) -> String
    
    var body: some View {
        Picker("Выберите", selection: $selection) {
            ForEach(options, id: \.self) { option in
                Text(title(option))
                    .tag(option)
            }
        }
        .pickerStyle(.segmented)
    }
}
