import SwiftUI

struct ChatView: View {
    @State private var searchText = ""
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
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
                .padding(.horizontal)
            }
            .scrollIndicators(.automatic)
        }
        .navigationTitle("Чаты")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Изм.") {
                    
                }
                .tint(.primary)
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Поиск"
        )
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
