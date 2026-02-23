import SwiftUI

struct CreateUserRequest: Encodable, Copyable {
    let name: String
    let role: Role
    let phone: String
}
