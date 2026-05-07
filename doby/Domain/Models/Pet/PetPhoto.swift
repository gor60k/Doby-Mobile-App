struct PetPhoto: Codable, Identifiable {
    let id: Int
    let imageURL: String
    let orderNumber: Int
    let isMain: Bool
}
