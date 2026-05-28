import SwiftUI

struct ChatRoomScreen: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    @Environment(\.dismiss) private var dismiss
    
    @State private var messageText = ""
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                
                ForEach(0..<20, id: \.self) { index in
                    
                    HStack {
                        
                        if index % 2 == 0 {
                            Spacer(minLength: 60)
                        }
                        
                        Text(index % 2 == 0 ? "Моё сообщение" : "Сообщение собеседника")
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(index % 2 == 0 ? primaryColorService.primaryColor.color.opacity(0.1) : Color.gray.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                        
                        if index % 2 != 0 {
                            Spacer(minLength: 60)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                HStack(spacing: 12) {
                    
                    Image("MockUserIcon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("username")
                            .font(.headline)
                        
                        Text("online")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                
                HStack(alignment: .center, spacing: 10) {
                    
                    // MARK: Attach Button
                    
                    Button {
                        print("Attach file")
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                            .frame(width: 38, height: 38)
                            .clipShape(Circle())
                    }
                    
                    // MARK: Input
                    
                    HStack(alignment: .bottom, spacing: 10) {
                        
                        TextField("Message", text: $messageText, axis: .vertical)
                            .lineLimit(1...6)
                        
                        if !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            
                            Button {
                                print("Send message")
                            } label: {
                                Image(systemName: "arrow.up.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundStyle(primaryColorService.primaryColor.color)
                            }
                            .transition(.scale.combined(with: .opacity))
                        }
                    }
                    .padding(.leading, 14)
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .animation(.easeInOut(duration: 0.2), value: messageText)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChatRoomScreen()
    }
    .PreviewAppEnvironment()
}

