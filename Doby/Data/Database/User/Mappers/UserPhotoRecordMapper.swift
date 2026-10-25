import Foundation

struct UserPhotoRecordMapper {
    nonisolated static func mapToRecord(from photo: Photo, userUUID: String) -> UserPhotoRecord {
        return UserPhotoRecord(
            id: photo.id,
            userUuid: userUUID,
            imageURL: photo.imageURL,
            orderNumber: photo.orderNumber,
            isMain: photo.isMain
        )
    }
    
    nonisolated static func mapToRecord(from photos: [Photo], userUUID: String) -> [UserPhotoRecord] {
        return photos.map { mapToRecord(from: $0, userUUID: userUUID) }
    }
    
    nonisolated static func mapToDomain(from record: UserPhotoRecord) -> Photo {
        return Photo(
            id: record.id,
            imageURL: record.imageURL,
            orderNumber: record.orderNumber,
            isMain: record.isMain
        )
    }
    
    nonisolated static func mapToDomain(from records: [UserPhotoRecord]) -> [Photo] {
        return records.map { mapToDomain(from: $0) }
    }
}
