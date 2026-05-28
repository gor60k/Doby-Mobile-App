import SwiftUI

struct PrimaryFormSectionHeader: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    let title: String
    let isRequired: Bool
    
    var body: some View {
        HStack(spacing: 6) {
            Text(title)
            
            if isRequired {
                Text("*")
                    .foregroundColor(primaryColorService.primaryColor.color)
            }
        }
    }
}
