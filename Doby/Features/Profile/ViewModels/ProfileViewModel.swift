import Foundation
import Observation

@MainActor
@Observable
final class ProfileViewModel: ViewModel {
    // MARK: - Инфраструктура
    private let viewContextService: ViewContextService
    private let currentUserProvider: CurrentUserProviding
    
    // MARK: - Репозитории сущностей
    private let userRepository: UserRepositoryProtocol
    private let petRepository: PetRepositoryProtocol
    private let chatRepository: ChatRepositoryProtocol
    
    private(set) var user: User?
    
    private let target: ProfileTarget
    
    init(
        viewContextService: ViewContextService,
        currentUserProvider: CurrentUserProviding,
        userRepository: UserRepositoryProtocol,
        petRepository: PetRepositoryProtocol,
        chatRepository: ChatRepositoryProtocol,
        
        target: ProfileTarget = .currentUser
    ) {
        self.viewContextService = viewContextService
        self.currentUserProvider = currentUserProvider
        self.userRepository = userRepository
        self.petRepository = petRepository
        self.chatRepository = chatRepository
        
        self.target = target
    }
    
    // MARK: - Публичные методы
    func load() async {
        switch target {
        case .currentUser: await loadCurrentUserProfile()
        case .user(let uuid): await loadProfile(with: uuid)
        }
    }
    
    func loadIfNeeded() async {}
    
    func refresh() async {}
    
    func createChat() async {
        let myUUID = currentUserProvider.currentUserUUID
        let otherUUID = viewContextService.viewedUser?.uuid
        
        await perform {
            guard let myUUID, let otherUUID else { return }
            
            let input = CreateChatInput.direct(participants: [myUUID, otherUUID])
            
            try await chatRepository.creageChat(input)
        }
    }
    
    // MARK: - Привытные методы
    private func loadCurrentUserProfile() async {
        await loadCurrentUser()
        
        guard let user else { return }
        await loadPets(for: user.uuid)
    }
    
    private func loadProfile(with uuid: String) async {
        await loadUser(with: uuid)
        
        guard let user else { return }
        await loadPets(for: user.uuid)
    }
    
    private func loadCurrentUser() async {
        await perform {
            let user = try await userRepository.getMe()
            self.user = user
            
            viewContextService.open(user: user)
        }
    }
    
    private func loadUser(with uuid: String) async {
        await perform {
            let user = try await userRepository.getUser(with: uuid)
            self.user = user
            
            viewContextService.open(user: user)
        }
    }
    
    private func loadPets(for uuid: String) async {
        await perform {
            try await petRepository.fetchPets(from: uuid)
        }
    }
}

extension ProfileViewModel {
    static var mock: ProfileViewModel {
        let viewContextService = ViewContextService(currentUserProvider: UserStorage())
        let currentUserProvider = UserStorage()
        let userRepository = MockUserRepository()
        let petRepository = MockPetRepository()
        let chatRepository = MockChatRepository()
        
        return ProfileViewModel(
            viewContextService: viewContextService,
            currentUserProvider: currentUserProvider,
            userRepository: userRepository,
            petRepository: petRepository,
            chatRepository: chatRepository,
        )
    }
}
