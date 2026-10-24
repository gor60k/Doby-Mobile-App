import Foundation
import Alamofire

struct UploadUserPhotoEndpoint: APIEndpointProtocol {
    typealias Response = [PhotoDTO]
    
    let request: PhotoRequest
    
    var isMultipart: Bool { true }
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/users/me/photos/" }
    var method: HTTPMethod { .post }
    
    func encodeMultipart(to formData: MultipartFormData) {
        formData.append(
            Data(request.image),
            withName: "image",
            fileName: "photo.jpeg",
            mimeType: "image/jpeg"
        )
        
        formData.append(Data("\(request.order_number)".utf8), withName: "order_number")
        formData.append(Data("\(request.is_main, default: "false")".utf8), withName: "is_main")
        
//        if let isMain = request.is_main {
//            formData.append(Data("\(isMain, default: "false")".utf8), withName: "is_main")
//        }
    }
}
