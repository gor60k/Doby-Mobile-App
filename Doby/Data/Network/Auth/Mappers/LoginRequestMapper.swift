struct LoginRequestMapper {
    static func map(input: LoginInput) -> LoginRequest {
        return LoginRequest(
            username: input.username,
            password: input.password
        )
    }
}
