import SwiftUI

struct OrdersListView: View {
    let orderType: OrderType
    let orders: [Order]
    
    private var filteredOrders: [Order] {
        orders.filter { $0.type == orderType }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(filteredOrders, id: \.self) { order in
                    PrimaryOrderCard(order: order)
                }
            }
            .padding(.horizontal)
        }
    }
}
