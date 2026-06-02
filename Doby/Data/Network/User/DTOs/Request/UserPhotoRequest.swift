nonisolated struct UserPhotoRequest: Codable {
    let image: String
    let order_number: Int
    let is_main: Bool?
}
