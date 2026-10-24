import Foundation
import GRDB

struct PetSnapshot: Decodable, Sendable, FetchableRecord {
    let pet: PetRecord
    let photos: [PetPhotoRecord]
}
