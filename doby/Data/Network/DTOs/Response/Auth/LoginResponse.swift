import Foundation

struct LoginResponse :Decodable, Encodable {
    let access: String
    let refresh: String
}
