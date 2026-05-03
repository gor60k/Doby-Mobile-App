import Foundation
import Alamofire

struct CreateEndpoint: APIEndpointProtocol {
    typealias Response = PetResponse
    
    let request: PetRequest
    
    var isMultipart: Bool { true }
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/pets/" }
    var method: HTTPMethod { .post }
    
    func encodeMultipart(to formData: MultipartFormData) {
        formData.append(Data(request.pet_type.rawValue.utf8), withName: "pet_type")
        formData.append(Data(request.name.utf8), withName: "name")
        formData.append(Data("\(request.age)".utf8), withName: "age")
        formData.append(Data(request.breed_name.utf8), withName: "breed_name")
        
        request.uploaded_photos.enumerated().forEach { index, data in
            formData.append(
                data,
                withName: "uploaded_photos",
                fileName: "photo_\(index).jpeg",
                mimeType: "image/jpeg"
            )
        }
        
        request.warning_tags.forEach { tag in
            formData.append(Data(tag.utf8), withName: "warning_tags")
        }
        
        request.specific_features.forEach { feature in
            formData.append(Data(feature.utf8), withName: "specific_features")
        }
                
        if let height = request.height {
            formData.append(Data(String(height).utf8), withName: "height")
        }
        
        if let weight = request.weight {
            formData.append(Data(String(weight).utf8), withName: "weight")
        }
        
        if let dietType = request.diet_type {
            formData.append(Data(request.diet_type!.utf8), withName: "diet_type")
        }
        
        if let dietPattern = request.diet_pattern {
            formData.append(Data(request.diet_pattern!.utf8), withName: "diet_pattern")
        }
        
        if let diet_additional_info = request.diet_additional_info {
            formData.append(Data(request.diet_additional_info!.utf8), withName: "diet_additional_info")
        }
    }
}

