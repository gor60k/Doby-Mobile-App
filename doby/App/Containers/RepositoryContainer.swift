@MainActor
struct RepositoryContainer {
    let authRepository: AuthRepositoryProtocol
    let userRepository: UserRepositoryProtocol
    let petRepository: PetRepositoryProtocol
}
