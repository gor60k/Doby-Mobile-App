enum PetRoute: Hashable {
    case petAdding
    case profile(id: Int)
    case petSettings(id: Int)
}
