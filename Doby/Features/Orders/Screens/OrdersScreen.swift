import SwiftUI

struct OrdersScreen: View {
    @State private var selectedTab = 0
    @State private var viewModel = OrdersViewModel()
    
    @State private var isPresented: Bool = false
    
    let openOrderTypes: () -> Void
    let openSitters: () -> Void
    
    init(
        openOrderTypes: @escaping () -> Void,
        openSitters: @escaping () -> Void
    ) {
        self.openOrderTypes = openOrderTypes
        self.openSitters = openSitters
    }
    
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
            onAddTap: { openOrderTypes() }
        )
        .ordersTopBar(selectedTab: $selectedTab)
    }
}
