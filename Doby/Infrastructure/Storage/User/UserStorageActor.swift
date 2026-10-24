import Foundation
import GRDB

actor UserStorageActor {
    private let dbPool: DatabasePool

    init(dbPool: DatabasePool) { self.dbPool = dbPool }

    nonisolated func observe(uuid: String) -> AsyncValueObservation<UserSnapshot?> {
        ValueObservation
            .tracking { db in try Self.request(uuid: uuid).fetchOne(db) }
            .values(in: dbPool)
    }

    func save(_ snapshot: UserSnapshot) async throws {
        try await dbPool.write { db in
            if let city = snapshot.city { try city.save(db) }
            try snapshot.user.save(db)

            try UserPhotoRecord
                .filter(Column("user_uuid") == snapshot.user.uuid)
                .deleteAll(db)
            for photo in snapshot.photos { try photo.insert(db) }

            try PetRecord.replaceAll(snapshot.pets, ownerUuid: snapshot.user.uuid, in: db)
        }
    }

    func fetch(uuid: String) async throws -> UserSnapshot? {
        try await dbPool.read { db in try Self.request(uuid: uuid).fetchOne(db) }
    }

    func delete(uuid: String) async throws {
        try await dbPool.write { db in _ = try UserRecord.deleteOne(db, key: uuid) }
    }

    private static func request(uuid: String) -> QueryInterfaceRequest<UserSnapshot> {
        UserRecord.filter(key: uuid)
            .including(optional: UserRecord.city)
            .including(all: UserRecord.photos)
            .including(all: UserRecord.pets.including(all: PetRecord.photos))
            .asRequest(of: UserSnapshot.self)
    }
}
