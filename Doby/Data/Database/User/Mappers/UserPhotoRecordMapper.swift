import Foundation

struct UserPhotoRecordMapper {
    nonisolated static func mapToRecord(from photo: UserPhoto, userUUID: String) -> UserPhotoRecord {
        return UserPhotoRecord(
            id: photo.id,
            userUuid: userUUID,
            imageURL: photo.imageURL,
            orderNumber: photo.orderNumber,
            isMain: photo.isMain
        )
    }
    
    nonisolated static func mapToRecord(from photos: [UserPhoto], userUUID: String) -> [UserPhotoRecord] {
        return photos.map { mapToRecord(from: $0, userUUID: userUUID) }
    }
    
    nonisolated static func mapToDomain(from record: UserPhotoRecord) -> UserPhoto {
        return UserPhoto(
            id: record.id,
            imageURL: record.imageURL,
            orderNumber: record.orderNumber,
            isMain: record.isMain
        )
    }
    
    nonisolated static func mapToDomain(from records: [UserPhotoRecord]) -> [UserPhoto] {
        return records.map { mapToDomain(from: $0) }
    }
}
