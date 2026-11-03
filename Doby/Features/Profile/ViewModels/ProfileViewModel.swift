import Foundation
import Observation

@MainActor
@Observable
final class ProfileViewModel: ViewModel {
    // MARK: - Зависимости
    private let userRepository: UserRepositoryProtocol
    private let petRepository: PetRepositoryProtocol

    // MARK: - Состояние
    let target: ProfileTarget
    private(set) var state: LoadState<ProfileContent> = .idle

    var isCurrentUser: Bool { target == .currentUser }
    
    var content: ProfileContent? {
        if case .loaded(let content) = state { return content }
        return nil
    }
    var user: User? { content?.user }

    // MARK: - Init
    init(
        userRepository: UserRepositoryProtocol,
        petRepository: PetRepositoryProtocol,
        target: ProfileTarget = .currentUser
    ) {
        self.userRepository = userRepository
        self.petRepository = petRepository
        self.target = target
    }

    // MARK: - Публичные методы
    func loadIfNeeded() async {
        guard case .idle = state else { return }
        await load()
    }

    func refresh() async {
        await load(showsLoading: false)
    }

    // MARK: - Загрузка
    private func load(showsLoading: Bool = true) async {
        let previous = state
        if showsLoading { state = .loading }

        do {
            let user = try await fetchUser()
            let pets = try await petRepository.fetchPets(from: user.uuid)
            state = .loaded(ProfileContent(user: user, pets: pets))
        } catch is CancellationError {
            state = previous
        } catch {
            // при refresh не затираем уже показанный профиль ошибкой
            if case .loaded = previous, !showsLoading { state = previous }
            else { state = .error(error) }
        }
    }

    private func fetchUser() async throws -> User {
        switch target {
        case .currentUser:
            return try await userRepository.getMe()
        case .user(let uuid):
            return try await userRepository.getUser(with: uuid)
        }
    }
}
