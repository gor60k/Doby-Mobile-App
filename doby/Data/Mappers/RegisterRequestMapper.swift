struct RegisterRequestMapper {
    static func map(input: RegisterInput) -> RegisterRequest {
        return RegisterRequest(
            username: input.username,
            password: input.password
        )
    }
}
