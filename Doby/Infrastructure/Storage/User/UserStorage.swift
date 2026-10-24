import Foundation
import Observation

@MainActor
@Observable
final class UserStorage {
    private let actor: UserStorageActor
    private var userUUID: String?
    @ObservationIgnored private var observationTask: Task<Void, Never>?

    /// nil, пока в кэше нет пользователя
    private(set) var user: User?

    init(actor: UserStorageActor) {
        self.actor = actor
    }

    // MARK: - Подписка

    /// Вызывать после входа или при смене пользователя
    func start(userUUID: String) {
        guard self.userUUID != userUUID else { return }
        stop()
        self.userUUID = userUUID

        let source = actor.observe(uuid: userUUID)
        observationTask = Task { [weak self] in
            do {
                for try await snapshot in source {
                    self?.user = snapshot.map(UserRecordMapper.mapToDomain(from:))
                }
            } catch {
                // залогировать через LogService
            }
        }
    }

    /// Вызывать при логауте
    func stop() {
        observationTask?.cancel()
        observationTask = nil
        userUUID = nil
        user = nil
    }

    // MARK: - CRUD

    /// Create / Update: полная синхронизация (пользователь, город, фото, питомцы)
    func save(_ user: User) async throws {
        let snapshot = UserRecordMapper.mapToRecord(from: user)
        try await actor.save(snapshot)
    }

    /// Read: разовое чтение, например чужого профиля
    func user(uuid: String) async throws -> User? {
        try await actor.fetch(uuid: uuid).map(UserRecordMapper.mapToDomain(from:))
    }

    /// Update: изменение полей текущего пользователя
    func patch(mutate: (inout User) -> Void) async throws {
        guard var user else { return }
        mutate(&user)
        try await save(user)
    }

    /// Delete: удалить пользователя из кэша (питомцы и фото уйдут каскадом)
    func remove(uuid: String) async throws {
        try await actor.delete(uuid: uuid)
    }

    /// Очистка при логауте или удалении аккаунта
    func clear() async throws {
        guard let userUUID else { return }
        try await actor.delete(uuid: userUUID)
        stop()
    }
}

extension UserStorage: CurrentUserProviding {
    var currentUserUUID: String? { user?.uuid }
}
