import SwiftUI

struct OrdersTopBarModifier: ViewModifier {
    @Binding var selectedTab: Int
    
    func body(content: Content) -> some View {
        content
            .safeAreaBar(edge: .top) {
                VStack {
                    Picker("", selection: $selectedTab) {
                        Text("Передержка").tag(0)
                        Text("Выгул").tag(1)
                        Text("Дневная няня").tag(2)
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.bottom, 8)
                .padding(.horizontal)
            }
    }
}

extension View {
    func ordersTopBar(selectedTab: Binding<Int>) -> some View {
        self.modifier(OrdersTopBarModifier(selectedTab: selectedTab))
    }
}
