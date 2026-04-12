import SwiftUI

struct PetView: View {
    @EnvironmentObject private var router: AppRouter
    @EnvironmentObject private var primaryColorService: PrimaryColorService
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(0..<3) { index in
                    Button(action: {
                        router.push(.pet(.profile))
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "pawprint.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(primaryColorService.currentColor.color)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Питомец \(index + 1)")
                                    .font(.headline)
                                
                                Text("Порода: Неизвестно")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Text("Возраст: \(2 + index) года")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            
            Button(action: {
                router.push(.petAdding)
            }) {
                Image(systemName: "plus")
            }
        }
        .overlay(alignment: .topTrailing) {
            UtilityButton(
                action: {
                    router.push(.petAdding)
//                    router.push(.profile(.settings))
                },
                icon: "plus"
            )
            .padding(.trailing, 16)
        }
    }
}

#Preview {
    PetView()
        .withAppEnvironment()
}
