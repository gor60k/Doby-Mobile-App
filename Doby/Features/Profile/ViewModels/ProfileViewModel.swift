import Foundation
import Observation

enum ProfileTarget {
    case currentUser
    case user(uuid: String)
}

@MainActor
@Observable
final class ProfileViewModel: ViewModel {
    private let viewContextService: ViewContextService
    
    private let userRepository: UserRepositoryProtocol
    private let petRepository: PetRepositoryProtocol
    private let chatRepository: ChatRepositoryProtocol
    
    private let storage: UserStorage
    
    private(set) var user: User?
    private var uuid: String?
    
    private let target: ProfileTarget
    
    init(
        viewContextService: ViewContextService,
        userRepository: UserRepositoryProtocol,
        petRepository: PetRepositoryProtocol,
        chatRepository: ChatRepositoryProtocol,
        storage: UserStorage,
        target: ProfileTarget = .currentUser
    ) {
        self.viewContextService = viewContextService
        self.userRepository = userRepository
        self.petRepository = petRepository
        self.chatRepository = chatRepository
        self.storage = storage
        
        self.target = target
    }
    
    func load() async {
        switch target {
        case .currentUser: await loadCurrentUserProfile()
        case .user(let uuid): await loadProfile(with: uuid)
        }
    }
    
    func loadIfNeeded() async {}
    
    func refresh() async {}
    
    func createChat() async {
        let myUUID = storage.user?.uuid
        let otherUUID = viewContextService.viewedUserUUID
        
        await perform {
            guard let myUUID, let otherUUID else { return }
            
            let input = CreateChatInput.direct(participants: [myUUID, otherUUID])
            
            try await chatRepository.creageChat(input)
        }
    }
    
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
            
            configureContext(with: user)
        }
    }
    
    private func loadUser(with uuid: String) async {
        await perform {
            let user = try await userRepository.getUser(with: uuid)
            self.user = user
            
            configureContext(with: user)
        }
    }
    
    private func loadPets(for uuid: String) async {
        await perform {
            try await petRepository.fetchPets(from: uuid)
        }
    }
    
    private func configureContext(with user: User) {
        viewContextService.configure(
            currentUserUUID: storage.user?.uuid,
            viewedUserUUID: user.uuid
        )
    }
}

extension ProfileViewModel {
    static var mock: ProfileViewModel {
        let viewContextService = ViewContextService()
        let userRepository = MockUserRepository()
        let petRepository = MockPetRepository()
        let chatRepository = MockChatRepository()
        let storage = UserStorage()
        
        return ProfileViewModel(
            viewContextService: viewContextService,
            userRepository: userRepository,
            petRepository: petRepository,
            chatRepository: chatRepository,
            storage: storage,
        )
    }
}
