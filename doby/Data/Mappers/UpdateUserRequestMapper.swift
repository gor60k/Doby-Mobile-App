struct UpdateUserRequestMapper {
    static func map(input: UpdateUserInput) -> UpdateUserRequest {
        return UpdateUserRequest(
            first_name: input.firstName,
            last_name: input.lastName,
            patronymic: input.patronymic,
            phone: input.phone,
            avatar: input.avatar,
            city: input.city.map(mapCity),
            bio: input.bio
        )
    }
    
    nonisolated private static func mapCity(_ input: City) -> CityDTO {
        CityDTO(
            name: input.name,
            translit: input.translit
        )
    }
}
