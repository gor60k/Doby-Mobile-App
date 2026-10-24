nonisolated struct PhotoDTO: Codable, Identifiable, Hashable {
    let id: Int
    let image_url: String
    let order_number: Int
    let is_main: Bool
}
