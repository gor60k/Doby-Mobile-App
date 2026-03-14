import SwiftUI

struct RegisterRequest: Encodable {
    let username: String
    let email: String
    let password: String
    let phone: String
    let city_translit: String?
}
