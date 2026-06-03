import Foundation
import Alamofire

struct UploadPetPhotoEndpoint: APIEndpointProtocol {
    typealias Response = PetPhotoDTO
    
    let request: PetPhotoRequest
    let petId: Int
    
    var isMultipart: Bool { true }
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/pets/\(petId)/photos/" }
    var method: HTTPMethod { .post }
    
    func encodeMultipart(to formData: MultipartFormData) {
        formData.append(Data(request.image.utf8), withName: "image")
        formData.append(Data("\(request.order_number)".utf8), withName: "order_number")
        
        if let isMain = request.is_main {
            formData.append(Data("\(isMain, default: "false")".utf8), withName: "is_main")
        }
    }
}
