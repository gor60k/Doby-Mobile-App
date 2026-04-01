import SwiftUI

struct ProfileServiceButton: View {
    @EnvironmentObject var primaryColorService: PrimaryColorService
    
    let serviceTitle: String
    let servicePrice: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(serviceTitle)
                    .foregroundColor(primaryColorService.currentColor.color)
                Spacer()
                
                Text("\(servicePrice)₽")
                    .foregroundColor(primaryColorService.currentColor.color)
                
                Image(systemName: "chevron.right")
                    .foregroundColor(primaryColorService.currentColor.color)
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(primaryColorService.currentColor.color.opacity(0.1)))
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
