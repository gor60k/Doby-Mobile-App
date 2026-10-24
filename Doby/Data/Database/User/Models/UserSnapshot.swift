import Foundation
import GRDB

struct UserSnapshot: Decodable, Sendable, FetchableRecord {
    let user: UserRecord
    let city: CityRecord?
    let photos: [UserPhotoRecord]
    let pets: [PetSnapshot]
}
