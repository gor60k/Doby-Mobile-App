import SwiftUI

struct ProfileServiceButton: View {
    @Environment(PrimaryColorService.self) var primaryColorService
    
    let serviceTitle: String
    let servicePrice: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(serviceTitle)
                    .foregroundColor(primaryColorService.primaryColor.color)
                Spacer()
                
                Text("\(servicePrice)₽")
                    .foregroundColor(primaryColorService.primaryColor.color)
                
                Image(systemName: "chevron.right")
                    .foregroundColor(primaryColorService.primaryColor.color)
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(primaryColorService.primaryColor.color.opacity(0.1)))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ProfileServiceButton(
        serviceTitle: "Выгул",
        servicePrice: "1000",
        action: {}
    )
    .padding()
}
