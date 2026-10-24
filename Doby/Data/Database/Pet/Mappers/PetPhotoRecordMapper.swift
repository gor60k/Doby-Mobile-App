import Foundation

struct PetPhotoRecordMapper {
    nonisolated static func mapToRecord(from photo: PetPhoto, petId: Int) -> PetPhotoRecord {
        return PetPhotoRecord(
            id: photo.id,
            petId: petId,
            imageURL: photo.imageURL,
            orderNumber: photo.orderNumber,
            isMain: photo.isMain
        )
    }
    
    nonisolated static func mapToDomain(from record: PetPhotoRecord) -> PetPhoto {
        return PetPhoto(
            id: record.id,
            imageURL: record.imageURL,
            orderNumber: record.orderNumber,
            isMain: record.isMain
        )
    }
}
