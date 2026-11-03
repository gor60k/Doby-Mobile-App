import Foundation

struct PetRecordMapper {
    nonisolated static func mapToRecord(from pet: Pet) -> PetSnapshot {
        let record = PetRecord(
            id: pet.id,
            petType: pet.petType,
            ownerUuid: pet.ownerUUID,
            name: pet.name,
            age: pet.age,
            gender: pet.gender,
            height: pet.height,
            weight: pet.weight,
            breedName: pet.breedName,
            dietType: pet.dietType,
            dietPatterns: pet.dietPatterns,
            warningTags: pet.warningTags,
            specificTags: pet.specificTags,
            additionalInfo: pet.additionalInfo,
            dietAdditionalInfo: pet.dietAdditionalInfo
        )

        let photos = pet.photos.map {
            PetPhotoRecordMapper.mapToRecord(from: $0, petId: pet.id)
        }

        return PetSnapshot(
            pet: record,
            photos: photos
        )
    }

    nonisolated static func mapToRecord(from pets: [Pet]) -> [PetSnapshot] {
        pets.map(mapToRecord(from:))
    }

    nonisolated static func mapToDomain(from snapshot: PetSnapshot) -> Pet {
        let record = snapshot.pet

        return Pet(
            id: record.id,
            petType: record.petType,
            ownerUUID: record.ownerUuid,
            name: record.name,
            age: record.age,
            gender: record.gender,
            height: record.height,
            weight: record.weight,
            breedName: record.breedName,
            dietType: record.dietType,
            dietPatterns: record.dietPatterns,
            warningTags: record.warningTags,
            specificTags: record.specificTags,
            additionalInfo: record.additionalInfo,
            dietAdditionalInfo: record.dietAdditionalInfo,
            photos: snapshot.photos.map(PetPhotoRecordMapper.mapToDomain(from:))
        )
    }

    nonisolated static func mapToDomain(from snapshots: [PetSnapshot]) -> [Pet] {
        snapshots.map(mapToDomain(from:))
    }
}
