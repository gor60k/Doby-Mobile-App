import Foundation
import Observation
import GRDB

@MainActor
@Observable
final class PetStorage {
    private let actor: PetStorageActor
    private var ownerUUID: String?
    @ObservationIgnored private var observationTask: Task<Void, Never>?

    /// nil, пока первая выборка из БД не пришла
    private(set) var pets: [Pet]?

    init(actor: PetStorageActor) {
        self.actor = actor
    }

    // MARK: - Подписка

    /// Вызывать после входа или при смене пользователя
    func start(ownerUUID: String) {
        guard self.ownerUUID != ownerUUID else { return }
        stop()
        self.ownerUUID = ownerUUID

        let source = actor.observeAll(ownerUUID: ownerUUID)
        observationTask = Task { [weak self] in
            do {
                for try await items in source {
                    self?.pets = PetRecordMapper.mapToDomain(from: items)
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
        ownerUUID = nil
        pets = nil
    }

    // MARK: - CRUD

    func set(_ pets: [Pet]) async throws {
        guard let ownerUUID else { return }
        let items = PetRecordMapper.mapToRecord(from: pets)
        try await actor.replaceAll(items, ownerUUID: ownerUUID)
    }

    func update(_ pet: Pet) async throws {
        let snapshot = PetRecordMapper.mapToRecord(from: pet)
        try await actor.save(snapshot.pet, with: snapshot.photos)
    }

    func patch(with petId: Int, mutate: (inout Pet) -> Void) async throws {
        guard var pet = pets?.first(where: { $0.id == petId }) else { return }
        mutate(&pet)
        try await update(pet)
    }

    func remove(id: Int) async throws {
        try await actor.delete(by: id)
    }

    func clear() async throws {
        guard let ownerUUID else { return }
        try await actor.deleteAll(ownerUUID: ownerUUID)
    }

    func pet(id: Int) async throws -> Pet? {
        let record = try await actor.fetch(with: id)
        
        guard var record = record else { return nil }
        
        let pet = PetRecordMapper.mapToDomain(from: record)
        
        return pet
    }
}
