import SwiftUI

struct RegisterRequest: Encodable {
    let id: String
    let name: String
    let email: String
    let password: String
}
