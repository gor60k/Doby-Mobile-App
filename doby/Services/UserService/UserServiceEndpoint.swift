enum UserServiceEndpoint {
    case getAllUsers
    case getUser(id: String)
    case createUser(user: CreateUserRequestModel)
}

