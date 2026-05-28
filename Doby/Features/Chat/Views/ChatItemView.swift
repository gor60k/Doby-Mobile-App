import SwiftUI

struct ChatItemView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    let chatId: Int
    let userIcon: String
    let username: String
    let lastMessage: String
    let lastMessageTime: String
    let openChatroom: (Int) -> Void
    
    var body: some View {
        Button(action: {
            openChatroom(chatId)
        }) {
            VStack(spacing: 0) {
                HStack(alignment: .top, spacing: 12) {
                    Image(userIcon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(alignment: .center) {
                            Text(username)
                                .font(.system(.headline, design: .rounded))
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            Text(lastMessageTime)
                                .font(.system(.footnote, design: .rounded))
                                .foregroundStyle(.secondary)
                        }
                        
                        Text(lastMessage)
                            .font(.system(.body, design: .rounded))
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical, 12)
                
                Divider()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack {
        ChatItemView(
            chatId: 1,
            userIcon: "MockUserIcon",
            username: "User",
            lastMessage: "привет, хочешь ко мне на остров?",
            lastMessageTime: "11:56",
            openChatroom: { id in }
        )
    }
    .padding()
    .PreviewAppEnvironment()
}
