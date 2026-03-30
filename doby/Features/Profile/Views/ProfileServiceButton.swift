import SwiftUI

struct ProfileServiceButton: View {
    let serviceTitle: String
    let servicePrice: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(serviceTitle)
                    .foregroundColor(.primaryYellow)
                Spacer()
                
                Text("\(servicePrice)₽")
                    .foregroundColor(.primaryYellow)
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.primaryYellow)
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(.primaryYellowLight))
//            .glassEffect(
//                .regular
//                    .tint(.primaryYellowLight)
//                    .interactive(),
//            )
            
            
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
