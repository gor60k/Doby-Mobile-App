import SwiftUI

struct SettingsAppearensView: View {
    @Environment(ThemeService.self) private var themeService
    @Environment(PrimaryColorService.self) var primaryColorService
    
    @State var themeSelection: AppTheme = .system
    @State var primaryColorSelection: AppPrimaryColor = .yellow
    
    let themeOptions: [AppTheme] = [.system, .dark, .light]
    let primaryOptions: [AppPrimaryColor] = [.yellow, .blue, .green]
    
    var body: some View {
        Form {
            Section(header: Text("Тема")) {
                Picker("Выберите", selection: $themeSelection) {
                    ForEach(themeOptions, id: \.self) { option in
                        Text(option.rawValue)
                            .tag(option)
                    }
                }
                .onChange(of: themeSelection) { oldValue, newValue in
                    themeService.theme = newValue
                }
                .onAppear {
                    themeSelection = themeService.theme
                }
                
                Picker("Акцентный цвет", selection: $primaryColorSelection) {
                    ForEach(primaryOptions, id: \.self) { option in
                        Text(option.rawValue)
                            .tag(option)
                    }
                }
                .onChange(of: primaryColorSelection) { oldValue, newValue in
                    primaryColorService.setPrimaryColor(newValue)
                }
                .onAppear {
                    primaryColorSelection = primaryColorService.primaryColor
                }
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(primaryColorService.primaryColor.color)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
            }
        }
        .navigationTitle("Внешний вид")
        .navigationBarTitleDisplayMode(.inline)
    }
}
