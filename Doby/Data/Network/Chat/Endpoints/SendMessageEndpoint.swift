import Foundation
import Alamofire

struct SendMessageEndpoint: APIEndpointProtocol {
    typealias Response = MessageDTO
    
    let request: MessageRequest
    
    var isMultipart: Bool { true }
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/chat/messages/" }
    var method: HTTPMethod { .post }
    
    func encodeMultipart(to formData: MultipartFormData) {
        formData.append(Data("\(request.chat)".utf8), withName: "chat")
        formData.append(Data(request.text.utf8), withName: "text")
        formData.append(Data(request.media_file.utf8), withName: "media_file")
    }
}
