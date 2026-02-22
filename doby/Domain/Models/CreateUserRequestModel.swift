import SwiftUI

struct CreateUserRequestModel: Encodable, Copyable {
    let name: String
    let role: String
    let phone: String
}
