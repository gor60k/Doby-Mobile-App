import SwiftUI

struct SettingsPersonalInfoView: View {
    @Binding var name: String
    @Binding var surname: String
    @Binding var phone: String
    @Binding var city: City
    
    var body: some View {
        Section("Личные данные") {
            TextField("Имя", text: $name)
                .textInputAutocapitalization(.words)
            
            TextField("Фамилия", text: $surname)
                .textInputAutocapitalization(.words)
            
            TextField("Номер телефона", text: $phone)
                .keyboardType(.phonePad)
                .textContentType(.telephoneNumber)
            
            TextField("Город", text: $city.name)
                .textInputAutocapitalization(.words)
        }
    }
}
