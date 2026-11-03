import Foundation

struct PetPhotoRecordMapper {
    nonisolated static func mapToRecord(from photo: Photo, petId: Int) -> PetPhotoRecord {
        return PetPhotoRecord(
            id: photo.id,
            petId: petId,
            imageUrl: photo.imageURL,
            orderNumber: photo.orderNumber,
            isMain: photo.isMain
        )
    }
    
    nonisolated static func mapToDomain(from record: PetPhotoRecord) -> Photo {
        return Photo(
            id: record.id,
            imageURL: record.imageUrl,
            orderNumber: record.orderNumber,
            isMain: record.isMain
        )
    }
}
