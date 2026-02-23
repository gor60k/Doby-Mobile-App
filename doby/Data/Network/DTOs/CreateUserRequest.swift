import SwiftUI

struct CreateUserRequest: Encodable, Copyable {
    let name: String
    let email: String
    let password: String
    let role: Role
}
