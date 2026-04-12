import SwiftUI

protocol UserProtocol {
    var uuid: UUID { get }
    var username: String { get }
    var first_name: String? { get }
    var last_name: String? { get }
    var patronymic: String? { get }
    var avatar: String? { get }
    var phone: String? { get }
    var city: CityDTO? { get }
    var bio: String? { get }
    var sitter_profile: SitterProfileDTO? { get }
}
