import SwiftUI

struct PrimaryPicker: View {
    
    @Binding var selection: String
    let options: [String]
    
    var body: some View {
        Picker("Выберите", selection: $selection) {
            ForEach(options, id: \.self) { option in
                Text(option)
            }
        }
        .pickerStyle(.segmented)
    }
}
