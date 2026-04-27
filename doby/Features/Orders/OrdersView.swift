import SwiftUI

struct OrdersView: View {
    @State private var selectedTab = 0
    @State private var viewModel = OrdersViewModel()
    
    var body: some View {
        PrimaryTabsPager(
            selectedIndex: $selectedTab,
            pageCount: viewModel.orders.count
        ) {
            OrdersListView(orderType: .boarding, orders: viewModel.orders)
            
            OrdersListView(orderType: .walking, orders: viewModel.orders)
            
            OrdersListView(orderType: .daycare, orders: viewModel.orders)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Заказы")
        .navigationBarTitleDisplayMode(.inline)
        .ordersToolbar(
            onEditTap: {},
            onAddTap: {}
        )
        .ordersTopBar(selectedTab: $selectedTab)
    }
}

#Preview {
    NavigationStack {
        OrdersView()
            .withAppEnvironment()
    }
}
