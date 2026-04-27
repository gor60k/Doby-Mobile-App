

import Foundation

struct UserMapper {
    static func map(dto: UserDTO) -> User {
        User(
            uuid: dto.uuid,
            username: dto.username,
            firstName: dto.first_name,
            lastName: dto.last_name,
            patronymic: dto.patronymic,
            avatar: dto.avatar,
            phone: dto.phone,
            city: dto.city.map(mapCity),
            bio: dto.bio
        )
    }
    
    private static func mapCity(_ dto: CityDTO) -> City {
        City(
            name: dto.name,
            translit: dto.translit
        )
    }
}
