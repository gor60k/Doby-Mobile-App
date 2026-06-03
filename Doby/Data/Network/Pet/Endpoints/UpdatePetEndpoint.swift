import Foundation
import Alamofire

struct UpdatePetEndpoint: APIEndpointProtocol {
    typealias Response = PetDTO
    
    let request: UpdatePetRequest
    let petId: Int
    
    var isMultipart: Bool { true }
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/pets/\(petId)/" }
    var method: HTTPMethod { .patch }
    
    func encodeMultipart(to formData: MultipartFormData) {
        
        if let petType = request.pet_type {
            formData.append(Data(petType.rawValue.utf8), withName: "pet_type")
        }
        
        if let name = request.name {
            formData.append(Data(name.utf8), withName: "name")
        }
        
        if let age = request.age {
            formData.append(Data(String(age).utf8), withName: "age")
        }
        
        if let breedName = request.breed_name {
            formData.append(Data(breedName.utf8), withName: "breed_name")
        }
        
        if let uploadedPhotos = request.uploded_photos {
            uploadedPhotos.enumerated().forEach { index, data in
                formData.append(
                    data,
                    withName: "uploaded_photos",
                    fileName: "photo_\(index).jpeg",
                    mimeType: "image/jpeg"
                )
            }
        }
        
        if let warningTags = request.warning_tags {
            warningTags.forEach { tag in
                formData.append(Data(tag.utf8), withName: "warning_tags")
            }
        }
        
        if let specificFeatures = request.specific_features {
            specificFeatures.forEach { feature in
                formData.append(Data(feature.utf8), withName: "specific_features")
            }
        }
                
        if let height = request.height {
            formData.append(Data(String(height).utf8), withName: "height")
        }
        
        if let weight = request.weight {
            formData.append(Data(String(weight).utf8), withName: "weight")
        }
        
        if let dietType = request.diet_type {
            formData.append(Data(dietType.utf8), withName: "diet_type")
        }
        
        if let dietPattern = request.diet_pattern {
            formData.append(Data(dietPattern.utf8), withName: "diet_pattern")
        }
        
        if let dietAdditionalInfo = request.diet_additional_info {
            formData.append(Data(dietAdditionalInfo.utf8), withName: "diet_additional_info")
        }
    }
}
