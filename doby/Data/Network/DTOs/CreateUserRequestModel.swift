import SwiftUI

struct CreateUserRequestModel: Encodable, Copyable {
    let name: String
    let role: Role
    let phone: String
}
