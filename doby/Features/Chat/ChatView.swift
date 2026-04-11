import SwiftUI

struct ChatView: View {
    var body: some View {
        VStack {
            VStack {
                TextField("Поиск", text: .constant(""))
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<10, id: \.self) { _ in
                        VStack {
                            HStack(alignment: .center) {
                                Image("MockUserIcon")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Эпш")
                                            .font(.system(.headline, design: .rounded))
                                        
                                        Spacer()
                                        
                                        Text("11:56")
                                            .font(.system(.footnote, design: .rounded))
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Text("Эпш:")
                                        .font(.system(.body, design: .rounded))
                                        .foregroundColor(.primaryYellow)
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
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal)
        .background(.primaryBackground)
    }
}

#Preview {
    ChatView()
}

