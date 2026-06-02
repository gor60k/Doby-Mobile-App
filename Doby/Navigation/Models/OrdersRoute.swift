enum OrdersRoute: Hashable {
    case orderTypes
    case sitters
    case profile(uuid: String)
    case petProfile(id: Int)
    case chatRoom(id: Int)
}
