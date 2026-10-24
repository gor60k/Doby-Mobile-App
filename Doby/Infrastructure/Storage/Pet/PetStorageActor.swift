import Foundation
import GRDB

actor PetStorageActor {
    
    private let dbPool: DatabasePool
    
    init(dbPool: DatabasePool) {
        self.dbPool = dbPool
    }
    
    nonisolated func observeAll(ownerUUID: String) -> AsyncValueObservation<[PetSnapshot]> {
        ValueObservation
            .tracking { db in
                try PetRecord.filter(Column("owner_uuid") == ownerUUID)
                    .including(all: PetRecord.photos)
                    .asRequest(of: PetSnapshot.self)
                    .fetchAll(db)
            }
            .values(in: dbPool)
    }
    
    func save(_ pet: PetRecord, with photos: [PetPhotoRecord]) async throws {
        try await dbPool.write { db in
            try pet.save(db)
            try PetPhotoRecord.filter(Column("pet_id") == pet.id).deleteAll(db)
            for photo in photos { try photo.insert(db) }
        }
    }
    
//    func replaceAll(_ items: [(PetRecord, [PetPhotoRecord])], ownerUUID: String) async throws {
//        try await dbPool.write { db in
//            let ids = items.map(\.0.id)
//            try PetRecord
//                .filter(Column("owner_uuid") == ownerUUID)
//                .filter(!ids.contains(Column("id")))
//                .deleteAll(db)
//            for (pet, photos) in items {
//                try pet.save(db)
//                try PetPhotoRecord.filter(Column("pet_id") == pet.id).deleteAll(db)
//                for photo in photos { try photo.insert(db) }
//            }
//        }
//    }
    
    func replaceAll(_ items: [PetSnapshot], ownerUUID: String) async throws {
        try await dbPool.write { db in
            try PetRecord.replaceAll(items, ownerUuid: ownerUUID, in: db)
        }
    }
    
    func fetch(with id: Int) async throws -> PetSnapshot? {
        try await dbPool.read { db in
            try PetRecord.filter(id: id)
                .including(all: PetRecord.photos)
                .asRequest(of: PetSnapshot.self)
                .fetchOne(db)
        }
    }
    
    func fetchAll(ownerUUID: String) async throws -> [PetSnapshot] {
        try await dbPool.read { db in
            try PetRecord.filter(Column("owner_uuid") == ownerUUID)
                .including(all: PetRecord.photos)
                .asRequest(of: PetSnapshot.self)
                .fetchAll(db)
        }
    }
    
    func delete(by id: Int) async throws {
        try await dbPool.write { db in _ = try PetRecord.deleteOne(db, id: id) }
    }
    
    func deleteAll(ownerUUID: String) async throws {
        try await dbPool.write { db in
            _ = try PetRecord.filter(Column("owner_uuid") == ownerUUID).deleteAll(db)
        }
    }
}
