import SwiftUI

struct RegisterRequest: Encodable {
    let name: String
    let email: String
    let password: String
    let role: Role
}
