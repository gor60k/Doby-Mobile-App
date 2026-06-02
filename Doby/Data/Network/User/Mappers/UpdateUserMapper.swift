struct UpdateUserMapper {
    nonisolated static func mapToRequest(input: UpdateUserInput) -> UpdateUserRequest {
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
}
