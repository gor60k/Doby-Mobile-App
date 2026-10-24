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
//    private let chatRepository: ChatRepositoryProtocol
    
    private(set) var user: User?
    private(set) var pets: [Pet] = []
    
    private let target: ProfileTarget
    var isCurrentUser: Bool {
        viewContextService.isCurrentUser
    }
    
    init(
        viewContextService: ViewContextService,
        currentUserProvider: CurrentUserProviding,
        userRepository: UserRepositoryProtocol,
        petRepository: PetRepositoryProtocol,
//        chatRepository: ChatRepositoryProtocol,
        target: ProfileTarget = .currentUser
    ) {
        self.viewContextService = viewContextService
        self.currentUserProvider = currentUserProvider
        self.userRepository = userRepository
        self.petRepository = petRepository
//        self.chatRepository = chatRepository
        self.target = target
    }
    
    // MARK: - Публичные методы
    func load() async {
        await perform {
            let user = try await getUser()
            self.user = user
            
            viewContextService.open(user: user)
            
            async let petsTask = petRepository.fetchPets(from: user.uuid)
            self.pets = try await petsTask
        }
    }
    
    func loadIfNeeded() async {
        if user == nil {
            await load()
        }
    }
    
    func refresh() async {
        await load()
    }
    
    func createChat() async {
        let myUUID = currentUserProvider.currentUserUUID
        let otherUUID = viewContextService.viewedUser?.uuid
        
        await perform {
            guard let myUUID, let otherUUID else { return }
            
            let input = CreateChatInput.direct(participants: [myUUID, otherUUID])
//            try await chatRepository.creageChat(input)
        }
    }
    
    // MARK: - Привытные методы
    private func getUser() async throws -> User {
        switch target {
        case .currentUser:
            return try await userRepository.getMe()
        case .user(let uuid):
            return try await userRepository.getUser(with: uuid)
        }
    }
}
