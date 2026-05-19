struct UpdateUserRequestMapper {
    static func map(input: UpdateUserInput) -> UpdateUserRequest {
        return UpdateUserRequest(
            first_name: input.firstName,
            last_name: input.lastName,
            patronymic: input.patronymic,
            phone: input.phone,
            avatar: input.avatar,
            city: input.city,
            bio: input.bio
        )
    }
    
    nonisolated private static func mapCity(_ input: City) -> CityDTO {
        CityDTO(
            id: input.id,
            name: input.name,
            translit: input.translit
        )
    }
}
