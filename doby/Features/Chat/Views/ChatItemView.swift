import SwiftUI

struct ChatItemView: View {
    @Environment(PrimaryColorService.self) private var primaryColorService
    
    let userIcon: String
    let username: String
    
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Image(userIcon)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(username)
                            .font(.system(.headline, design: .rounded))
                        
                        Spacer()
                        
                        Text("11:56")
                            .font(.system(.footnote, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                    
                    Text("Эпш:")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(primaryColorService.primaryColor.color)
                    Text("привет, хочешь ко мне на остров?")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
        }
    }
}


