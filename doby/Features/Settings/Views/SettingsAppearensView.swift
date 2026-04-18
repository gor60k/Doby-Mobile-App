import SwiftUI

struct SettingsAppearensView: View {
    @EnvironmentObject private var themeService: ThemeService
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
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
                    primaryColorSelection = primaryColorService.currentColor
                }
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(primaryColorService.currentColor.color)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
            }
        }
        .navigationTitle("Внешний вид")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsAppearensView()
        .environmentObject(ThemeService())
        .environmentObject(PrimaryColorService())
}
