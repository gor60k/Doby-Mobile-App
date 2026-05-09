struct RefreshRequestMapper {
    static func map(input: RefreshInput) -> RefreshRequest {
        return RefreshRequest(
            refresh: input.refresh
        )
    }
}
