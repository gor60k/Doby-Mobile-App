import Foundation

struct UserRecordMapper {
    nonisolated static func mapToRecord(from user: User) -> UserSnapshot {
        let record = UserRecord(
            uuid: user.uuid,
            username: user.username,
            firstName: user.firstName,
            lastName: user.lastName,
            patronymic: user.patronymic,
            phone: user.phone,
            cityId: user.city?.id ?? 0,
            bio: user.bio
        )
        
        return UserSnapshot(
            user: record,
            city: user.city.map(CityRecordMapper.mapToRecord(from:)),
            photos: UserPhotoRecordMapper.mapToRecord(from: (user.photos ?? []), userUUID: user.uuid),
            pets: PetRecordMapper.mapToRecord(from: (user.pets ?? []))
        )
    }
    
    nonisolated static func mapToDomain(from snapshot: UserSnapshot) -> User {
        return User(
            uuid: snapshot.user.uuid,
            username: snapshot.user.username,
            firstName: snapshot.user.firstName,
            lastName: snapshot.user.lastName,
            patronymic: snapshot.user.patronymic,
            phone: snapshot.user.phone,
            city: snapshot.city.map(CityRecordMapper.mapToDomain(from:)),
            bio: snapshot.user.bio,
            pets: PetRecordMapper.mapToDomain(from: snapshot.pets),
            photos: snapshot.photos.map(UserPhotoRecordMapper.mapToDomain(from:))
        )
    }
}
